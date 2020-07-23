# Swift-MVVM-Examples
Swift MVVM Examples

Implementation
 Used open source news feed API from algolia

-View controller
  Creates the viewModel (possibly with initial model data), and set up bindings (i.e. closures) so the view controller is informed of changes that take place in the viewModel

-View model
  Performs requests, and informs the view controller of changes
  Should be UIKit independent
  Typically formats data to be formatted for the view controller

-Model
  A typical data model

Note:Used Decodable Protocal

