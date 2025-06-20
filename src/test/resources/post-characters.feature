@getCharacters
Feature: Test cases to post characters /api/characters

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

	Scenario: T-API-MRV-001-CA1- create character (successful)
		Given path '/api/characters'
		And request { name: '#(characterName)', alterego: '#(characterAlterego)', description: '#(characterDescription)', powers: '#(characterPowers)' }
		When method POST
		Then status 201
		And match response.message == 'Created'

	Scenario: T-API-MRV-002-CA2- create character (duplicate name)
		Given path '/api/characters'
		And request { name: '#(characterName)', alterego: '#(characterAlterego)', description: '#(characterDescription)', powers: '#(characterPowers)' }
		When method POST
		Then status 400
		And match response.error == 'Character name already exists'

	Scenario: T-API-MRV-003-CA3- create character (missing name)
		Given path '/api/characters'
		And request { alterego: '#(characterAlterego)', description: '#(characterDescription)', powers: '#(characterPowers)' }
		When method POST
		Then status 400
		And match response.name == expectedResponse.name

	Scenario: T-API-MRV-003-CA4- create character (missing alterego)
		Given path '/api/characters'
		And request { name: '#(characterName)', description: '#(characterDescription)', powers: '#(characterPowers)' }
		When method POST
		Then status 400
		And match response.alterego == expectedResponse.alterego

	Scenario: T-API-MRV-003-CA5- create character (missing description)
		Given path '/api/characters'
		And request { name: '#(characterName)', alterego: '#(characterAlterego)', powers: '#(characterPowers)' }
		When method POST
		Then status 400
		And match response.description == expectedResponse.description

	Scenario: T-API-MRV-003-CA6- create character (missing powers)
		Given path '/api/characters'
		And request { name: '#(characterName)', alterego: '#(characterAlterego)', description: '#(characterDescription)' }
		When method POST
		Then status 400
		And match response.powers == expectedResponse.powers