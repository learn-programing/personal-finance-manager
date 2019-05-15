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

  private HashMap<String, Token> tokens = new HashMap<>();

  /**   [LOGGING IN]
   * possibly need method like generateTokens (both access and refresh) to return it to userService
   *
   *
   */
  public Token generateToken(User user) {

    UUID uuid = UUID.randomUUID();
    Token token = new Token(uuid.toString(), user.getId(), ZonedDateTime.now().plusMinutes(15));
    tokens.put(token.getToken(), token);
    return token;
  }

  public boolean validateToken(String token) {
    Token tokenFromDb = tokens.get(token);

    if (tokenFromDb == null) {
      return false;
    }

    ZonedDateTime expiryDate = tokenFromDb.getExpiryDate();
    if (expiryDate == null) {
      tokens.remove(token);
      throw new IllegalStateException("Token expiry time does not exist");
    }

    return expiryDate.isAfter(ZonedDateTime.now());
  }

  public long getUserIdBasedOnToken(String token) {
    Token tokenFromDb = tokens.get(token);

    if (tokenFromDb == null) {
      throw new IllegalStateException("Provided token does not exist");
    }

    return tokenFromDb.getUserId();
  }

}
