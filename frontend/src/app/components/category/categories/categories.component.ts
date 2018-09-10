import {Component, OnInit} from '@angular/core';
import {Category} from '../category';
import {CategoryService} from '../category-service/category.service';
import {AlertsService} from '../../alert/alerts-service/alerts.service';
import {Sortable} from '../../../helpers/sortable';
import { TranslateService } from '@ngx-translate/core';

@Component({ // TODO categories in dropdows should display with parent category e.g. Car > Parts (try using filter for it)
  selector: 'app-categories',
  templateUrl: './categories.component.html',
  styleUrls: ['./categories.component.css']
})
export class CategoriesComponent extends Sortable implements OnInit {
  categories: Category[] = [];
  addingMode = false;
  newCategory: Category = new Category();

  constructor(private categoryService: CategoryService, private alertService: AlertsService, private translate: TranslateService) {
    super('name');
  }

  ngOnInit() {
    this.getCategories();
  }

  getCategories(): void {
    this.categoryService.getCategories()
      .subscribe(categories => {
        this.categories = categories;
      });
  }

  deleteCategory(category) {
    if (confirm(this.translate.instant('error.wantDeleteCategory'))) {
      this.categoryService.deleteCategory(category.id)
        .subscribe(() => {
          this.alertService.success(this.translate.instant('error.categoryDeleted'));
          const index: number = this.categories.indexOf(category);
          if (index !== -1) {
            this.categories.splice(index, 1);
          }
        });
    }
  }

  onShowEditMode(category: Category) {
    category.editMode = true;
    category.editedCategory = new Category();
    category.editedCategory.id = category.id;
    category.editedCategory.name = category.name;

    if (category.parentCategory != null) {
      category.editedCategory.parentCategory = category.parentCategory;

      // TODO that should not be needed if value in category is set correctly
      for (const categoryEntry of this.categories) {
        if (categoryEntry.id === category.editedCategory.parentCategory.id) {
          category.editedCategory.parentCategory = categoryEntry;
        }
      }
    }
  }

  onEditCategory(category: Category) {
    if (!this.validateCategory(category.editedCategory.name)) {
      return;
    }

    this.categoryService.editCategory(category.editedCategory)
      .subscribe(() => {
        this.alertService.success(this.translate.instant('error.categoryEdited'));
        Object.assign(category, category.editedCategory);
        category.editedCategory = new Category();
        // TODO get category from server
      });
  }

  onAddCategory() {
    if (!this.validateAddingCategory(this.newCategory.name)) {
      return;
    }

    this.categoryService.addCategory(this.newCategory)
      .subscribe(id => {
        this.newCategory.id = id;
        this.categories.push(this.newCategory);
        this.newCategory = new Category();
        this.alertService.success(this.translate.instant('error.categoryAdded'));
        this.addingMode = false;

        // TODO get category from server
      });
  }

  onRefreshCategories() {
    this.getCategories();
  }

  getParentCategoryName(category): string {
    if (category.parentCategory != null) {
      return category.parentCategory.name;
    }
    return this.translate.instant('cat.mainCategory');
  }

  getListOfPossibleParentCategories(cat: Category) {
    return this.categories.filter(category => {
      if (category.id === cat.id) {
        return false;
      }
      let categoryToCheck = category.parentCategory;
      while (categoryToCheck != null) {

        if (categoryToCheck.id === cat.id) {
          return false;
        }
        categoryToCheck = categoryToCheck.parentCategory;
      }
      return true;
    });
  }

  validateCategory(categoryName: string): boolean { // TODO pass category object
    if (categoryName == null || categoryName.trim() === '') {
      this.alertService.error(this.translate.instant('error.categoryNameEmpty'));
      return false; // TODO validate all - not break on first failure
    }
    if (categoryName.length > 100) {
      this.alertService.error((this.translate.instant('error.categoryTooLong')));
      return false;
    }
    return true;
  }

  validateAddingCategory(categoryName: string): boolean {
    if (!this.validateCategory(categoryName)) {
      return false;
    }

    if (this.categories.filter(category => category.name.toLowerCase() === categoryName.toLowerCase()).length > 0) {
      this.alertService.error(this.translate.instant('error.categoryAlreadyExists'));
      return false;
    }
    return true;
  }
}
