@deleteCharacters
Feature: Test cases to delete characters /api/characters

  Background:
    * def user = 'testuser'
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user
    * def characterId = 1

  Scenario: T-API-MRV-006-CA1- delete character (successful)
    Given path '/api/characters/' + characterId
    When method DELETE
    Then status 204

  Scenario: T-API-MRV-006-CA2- delete character (not found)
    Given path '/api/characters/999'
    When method DELETE
    Then status 404
    And match response.error == 'Character not found'

  Scenario: T-API-MRV-006-CA4- delete character (server error - 500)
    Given path '/api/characters/invalid'
    When method DELETE
    Then status 500
