package com.pfm.auth;

import java.time.ZonedDateTime;
import java.util.HashMap;
import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
@NoArgsConstructor
public class TokenService {

  private HashMap<String, Tokens> accessTokensStorage = new HashMap<>();
  private HashMap<String, Tokens> refreshTokenStorage = new HashMap<>();

  public Tokens generateTokens(User user) {

    UUID accessTokenUuid = UUID.randomUUID();
    UUID refreshTokenUuid = UUID.randomUUID();
    Tokens tokens = new Tokens(user.getId(), accessTokenUuid.toString(), ZonedDateTime.now().plusMinutes(15), refreshTokenUuid.toString(),
        ZonedDateTime.now().plusMinutes(60));
    accessTokensStorage.put(tokens.getAccessToken(), tokens);
    refreshTokenStorage.put(tokens.getRefreshToken(), tokens);

    return tokens;
  }

  public boolean validateAccessToken(String token) {
    Tokens tokensFromDb = accessTokensStorage.get(token);
    if (tokensFromDb == null) {
      return false;
    }

    ZonedDateTime expiryDate = tokensFromDb.getAccessTokenExpiryDate();
    if (expiryDate == null) {
      accessTokensStorage.remove(token);
      throw new IllegalStateException("Tokens expiry time does not exist");
    }

    return expiryDate.isAfter(ZonedDateTime.now());
  }

  public long getUserIdBasedOnAccessToken(String accessToken) {
    Tokens tokensFromDb = accessTokensStorage.get(accessToken);

    if (tokensFromDb == null) {
      throw new IllegalStateException("Provided accessToken does not exist");
    }

    return tokensFromDb.getUserId();
  }

  public long getUserIdBasedOnRefreshToken(String refreshToken) {
    Tokens tokensFromDb = refreshTokenStorage.get(refreshToken);

    if (tokensFromDb == null) {
      throw new IllegalStateException("Provided refreshToken does not exist");
    }

    return tokensFromDb.getUserId();
  }

  public Token generateAccessToken(String refreshToken) {
    validateRefreshToken(refreshToken);

    long userId = getUserIdBasedOnRefreshToken(refreshToken);
    Tokens tokens = refreshTokenStorage.get(refreshToken);
    UUID newAccessTokenUuid = UUID.randomUUID();
    Tokens tokensToUpdate = new Tokens(userId, newAccessTokenUuid.toString(), ZonedDateTime.now().plusMinutes(15), tokens.getRefreshToken(),
        tokens.getRefreshTokenExpiryDate());

    accessTokensStorage.put(tokensToUpdate.getAccessToken(), tokensToUpdate);
    refreshTokenStorage.put(tokensToUpdate.getRefreshToken(), tokensToUpdate);
    return new Token(tokensToUpdate.getAccessToken(), tokensToUpdate.getAccessTokenExpiryDate());
  }

  public boolean validateRefreshToken(String refreshToken) {
    if (refreshToken == null) {
      throw new IllegalStateException("RefreshToken cannot be null");
    }
    Tokens tokensFromDb = refreshTokenStorage.get(refreshToken);

    if (tokensFromDb == null) {
      return false;
    }
    ZonedDateTime expiryDate = tokensFromDb.getRefreshTokenExpiryDate();
    if (expiryDate == null) {
      accessTokensStorage.remove(tokensFromDb.getAccessToken());
      throw new IllegalStateException("RefreshToken expiry time does not exist");
    }
    return expiryDate.isAfter(ZonedDateTime.now());
  }

}
