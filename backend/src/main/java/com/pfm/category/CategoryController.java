package com.pfm.category;

import static com.pfm.config.MessagesProvider.CANNOT_DELETE_PARENT_CATEGORY;
import static com.pfm.config.MessagesProvider.getMessage;

import com.pfm.auth.UserProvider;
import com.pfm.category.requests.CategoryAddRequest;
import com.pfm.category.requests.CategoryRequestBase;
import com.pfm.category.requests.CategoryUpdateRequest;
import com.pfm.category.validation.CategoryValidator;
import com.pfm.history.HistoryEntryService;
import java.util.List;
import java.util.Optional;
import javax.validation.Valid;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@AllArgsConstructor
public class CategoryController implements CategoryApi {

  private final CategoryService categoryService;
  private final CategoryValidator categoryValidator;
  private final HistoryEntryService historyEntryService;
  private final UserProvider userProvider;

  private static <T extends CategoryRequestBase> Category convertToCategory(@RequestBody T categoryRequest) {
    Long parentCategoryId = categoryRequest.getParentCategoryId();

    return Category.builder()
        .id(null)
        .name(categoryRequest.getName())
        .parentCategory(parentCategoryId == null ? null : Category.builder().id(parentCategoryId).build())
        .priority(categoryRequest.getPriority())
        .build();
  }

  // TODO return only parent category id - not the entire object / objects chain

  @Override
  public ResponseEntity<Category> getCategoryById(@PathVariable long categoryId) {
    long userId = userProvider.getCurrentUserId();

    log.info("Retrieving category with id: {}", categoryId);
    Optional<Category> category = categoryService.getCategoryByIdAndUserId(categoryId, userId);

    if (category.isEmpty()) {
      log.info("CATEGORY with id {} was not found", categoryId);
      return ResponseEntity.notFound().build();
    }

    log.info("CATEGORY with id {} was successfully retrieved", categoryId);
    return ResponseEntity.ok(category.get());
  }

  @Override
  public ResponseEntity<List<Category>> getCategories() {
    long userId = userProvider.getCurrentUserId();

    log.info("Retrieving categories from database");
    List<Category> categories = categoryService.getCategories(userId);

    return ResponseEntity.ok(categories);
  }

  @Override
  @Transactional
  public ResponseEntity<?> addCategory(@Valid @RequestBody CategoryAddRequest categoryRequest) {
    long userId = userProvider.getCurrentUserId();

    log.info("Saving category {} to the database", categoryRequest.getName());
    Category category = convertToCategory(categoryRequest);

    Category createdCategory = categoryService.addCategory(category, userId);
    log.info("Saving category to the database was successful. CATEGORY id is {}", createdCategory.getId());
    historyEntryService.addHistoryEntryOnAdd(createdCategory, userId);

    return ResponseEntity.ok(createdCategory.getId());
  }

  @Override
  @Transactional
  public ResponseEntity<?> updateCategory(@PathVariable long categoryId, @Valid @RequestBody CategoryUpdateRequest categoryRequest) {
    long userId = userProvider.getCurrentUserId();

    Optional<Category> categoryByIdAndUserId = categoryService.getCategoryByIdAndUserId(categoryId, userId);

    if (categoryByIdAndUserId.isEmpty()) {
      log.info("No category with id {} was found, not able to update", categoryId);
      return ResponseEntity.notFound().build();
    }

    Category category = convertToCategory(categoryRequest);
    category.setId(categoryId);

    List<String> validationResult = categoryValidator.validateCategoryForUpdate(categoryId, userId, category);
    if (!validationResult.isEmpty()) {
      log.info("Category is not valid {}", validationResult);
      return ResponseEntity.badRequest().body(validationResult);
    }

    if (category.getParentCategory() != null) {
      category.setParentCategory(categoryService.getCategoryByIdAndUserId(category.getParentCategory().getId(), userId).orElse(null));
    }

    Category categoryToUpdate = categoryByIdAndUserId.get();
    historyEntryService.addHistoryEntryOnUpdate(categoryToUpdate, category, userId);

    categoryService.updateCategory(categoryId, userId, category);
    log.info("Category with id {} was successfully updated", categoryId);
    return ResponseEntity.ok().build();
  }

  @Override
  @Transactional
  public ResponseEntity<?> deleteCategory(@PathVariable long categoryId) {
    long userId = userProvider.getCurrentUserId();

    if (categoryService.getCategoryByIdAndUserId(categoryId, userId).isEmpty()) {
      log.info("No category with id {} was found, not able to delete", categoryId);
      return ResponseEntity.notFound().build();
    }

    if (categoryService.isParentCategory(categoryId)) { // TODO review log messages and make sure each one is useful and correct.
      log.info("Category is used as parent. CATEGORY {} delete is not possible", categoryId);
      return ResponseEntity.badRequest().body(getMessage(CANNOT_DELETE_PARENT_CATEGORY));
    }

    List<String> validationResults = categoryValidator.validateCategoryForDelete(categoryId);
    if (!validationResults.isEmpty()) {
      log.info("Category with id {} was found, in transaction or filter, not able to delete", categoryId);
      return ResponseEntity.badRequest().body(validationResults);
    }

    log.info("Attempting to delete category with id {}", categoryId);

    Category deletedCategory = categoryService.getCategoryByIdAndUserId(categoryId, userId).get();
    historyEntryService.addHistoryEntryOnDelete(deletedCategory, userId);

    categoryService.deleteCategory(categoryId);
    log.info("Category with id {} was deleted successfully", categoryId);

    return ResponseEntity.ok().build();
  }
}
