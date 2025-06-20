@getCharacters
Feature: Test cases to get characters /api/characters

  Background:
    * def user = 'testuser'
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user
    * def characterId = 1

  Scenario: T-API-MRV-001-CA1- get all characters
    Given path '/api/characters'
    When method GET
    Then status 200
    And match response != []

  Scenario: T-API-MRV-002-CA2- get character by ID (successful)
    Given path '/api/characters/' + characterId
    When method GET
    Then status 200
    And match response.id == characterId
    And match response.name != null

  Scenario: T-API-MRV-003-CA3- get character by ID (not found)
    Given path '/api/characters/999'
    When method GET
    Then status 404
    And match response.error == 'Character not found'

  Scenario: T-API-MRV-004-CA4- server error (500)
    Given path '/api/characters/invalid'
    When method GET
    Then status 500