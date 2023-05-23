# POKEDEX FLUTTER APPLICATION

Application made in flutter (3.10.1) with a simple struct of file layers. I did use [PokeApi](https://pokeapi.co/) as data resource.
About the layers of application: 
- Components: Layer where I put the common components.
- Integration: Layer of communication with API, responsible to GET data of Server.
- Models.Response: Layer that contains the models of API Objects.
- Service: Contains the business rules, like calculations to get OFFSET of search.
- View: Contains the two screens of APP.
- Configs: Contains the main values of application, like colors etc...
- Utils: Contains some methods used in app, like text formatter etc..

## VALIDATIONS
I didn't data validations because I trusted in API and in data default.
But if I didn't have that confidence, it would be nice to add validations on null values and guarantee the API return.


## USED LIBRARIES
- cupertino_icons: Default icons of app.
- http: To made HTTP request.
- infinite_scroll_pagination: To made default pagination with infinity scroll. 
- google_fonts: To use poppins font.
- flutter_spinkit: Used to show the loader when the pokemon is clicked
- cached_network_image: User to cache data images, using less internet show icons faster.