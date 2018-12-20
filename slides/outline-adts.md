* setup problem adts and optics solve
  * We need immutable data structures to represent our domain
  * We need to manipulate these data structures with the same level of ease that we do mutable data structures
* defined adts
  * adts are the data types we create to represent the entities in our domain model
  * they are commonly discussed in two different flavors: product types and sum types
  * Product Types
  * Sum Types
* define optics
  * Lens manipulates product types
  * Prism manipulates sum types
* adts how-to
  * product types:
    * scala: case classes for product types
    * typescript: interface with tag attribute 
    * typescript: class with tag attribute
  * sum types: 
    * scala: sealed trait
      * example pattern matching on class without sealed trait
      * example pattern matching on class with sealed trait
    * typescript: union type (tagged/discriminated union)
      * example pattern matching on interface without tag
      * example pattern matching with tag

* optics how-to
  * Libraries for optics
    * scala: monocle
    * typescript: monocle-ts 
  * Lens/Product Types 
    * Getting values is pretty easy in either Scala or TypeScript example without Lens
    * Getting values with Lens
      * Scala example
      * TypeScript example
    * Setting values is painful. 
      * Scala example: setting values without a Lens
      * Scala example: setting values with a Lens
      * TypeScript example: setting values without a Lens
      * TypeScript example: setting values with a Lens

  * Prism/Sum Types
    * Getting values from Sum types is a PITA
      * Scala examples
        * without Prism
        * with Prism
      * TypeScript example
    * Setting values is even more painful then Product types!
      * Scala example (if time permits)
      * TypeScript example (if time permits)
    * Setting values with prisms ain't so bad
      * Scala example
      * TypeScript example

  * Traversals / Folds: discuss they exist

* Aside for io-ts

* Additional materials
  * Ed Kmett on optics
  * Phil Freeman on profunctor-optics


