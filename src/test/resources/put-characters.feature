@putCharacters
Feature: Test cases to update characters /api/characters

  Background:
    * def user = 'testuser'
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user
    * def characterId = 1
    * def characterName = 'Kramerx'
    * def characterAlterego = 'Tony Stark'
    * def characterDescription = 'Genius billionaire'
    * def characterPowers = ['Armor']
    * def expectedResponse =
      """
      {
      name: 'Name is required',
      alterego: 'Alterego is required',
      description: 'Description is required',
      powers: 'Powers are required'
      }
      """

  Scenario: T-API-MRV-005-CA1- update character (successful)
    Given path '/api/characters/' + characterId
    And request { name: '#(characterName)', alterego: 'Updated Hero', description: 'Updated description', powers: ['Updated Power'] }
    When method PUT
    Then status 200

  Scenario: T-API-MRV-005-CA2- update character (missing name)
    Given path '/api/characters/' + characterId
    And request { alterego: '#(characterAlterego)', description: '#(characterDescription)', powers: '#(characterPowers)' }
    When method PUT
    Then status 400
    And match response.name == expectedResponse.name

  Scenario: T-API-MRV-005-CA3- update character (missing alterego)
    Given path '/api/characters/' + characterId
    And request { name: '#(characterName)', description: '#(characterDescription)', powers: '#(characterPowers)' }
    When method PUT
    Then status 400
    And match response.alterego == expectedResponse.alterego

  Scenario: T-API-MRV-005-CA4- update character (missing description)
    Given path '/api/characters/' + characterId
    And request { name: '#(characterName)', alterego: '#(characterAlterego)', powers: '#(characterPowers)' }
    When method PUT
    Then status 400
    And match response.description == expectedResponse.description

  Scenario: T-API-MRV-005-CA5- update character (missing powers)
    Given path '/api/characters/' + characterId
    And request { name: '#(characterName)', alterego: '#(characterAlterego)', description: '#(characterDescription)' }
    When method PUT
    Then status 400
    And match response.powers == expectedResponse.powers

  Scenario: T-API-MRV-005-CA6- update character (character not found)
    Given path '/api/characters/999'
    And request { name: '#(characterName)', alterego: '#(characterAlterego)', description: '#(characterDescription)', powers: '#(characterPowers)' }
    When method PUT
    Then status 404
    And match response.error == 'Character not found'

  Scenario: T-API-MRV-005-CA8- update character (server error - 500)
    Given path '/api/characters/invalid'
    And request { name: '#(characterName)', alterego: '#(characterAlterego)', description: '#(characterDescription)', powers: '#(characterPowers)' }
    When method PUT
    Then status 500
