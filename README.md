![iOS App Architecture](https://github.com/realm/realm-swift/raw/master/logo.png)

iOS App Architecture is a base project for iOS Applications. It defines different layers of project providing losely coupled code using familiar design patterns. Reduces project setup time for fast paced development

## Components

1. [Data](#data)
2. [Dependency Container](#dependency-container)
3. [Router](#router)
4. [UI Layer MVVM](#ui-layer)
5. [ThirdParty Dependencies](#thirdparty-dependencies)


### <a id="data">Data</a>
Data layer manages local and remote data. It is added as a swift package to the project. It uses repository pattern, protocols and factory pattern. Following are components used

* **Repositories:** A repository is defined using a <b>protocol</b> which provide us a blue print. A <b>class</b> conforms to repository protocol and provide it's implemetations. A <b>factory class</b> then provides a single make method which returns instance of repository. This allows to hide concrete classes from client.
* **Store:** If both local and remote data is manage by a repository then a Local and a Remote class are defined. These are then managed by a store which conforms to repository protocol.
* **Models:** Models are usually struct that define data models for <em>REST API's</em> or <em>Persistance Storage</em>.
* **RequestModel:** It provides implementation of network layer. Currently it uses a light weight swift package <b>[Api Client](https://github.com/mansoor92/ApiClient)</b> but you can replace it with any library without making changes in repositories.

### <a id="dependency-container">Dependency Container</a>
It manages all the dependencies of the application.It contains instances of <b>Request Model</b>, any <b>Persistance Storage</b> and repositories.It is initialize in <em>SceneDelegate</em> of application.

### <a id="router">Router</a>
It manages all the navigation in the application. It initializes <em>ViewControllers</em> and displays them on the screen.

### <a id="ui-layer">UI Layer</a>
UI Layer contains all the views in the application. It uses MVVM to separate the code to create a view and it's business logic. It consists of following components

* **ViewModelInput<Protocol>:** Defines input method for the view model. It is used by view to send events to viewModel.
* **ViewModelOutput<Protocol>:** Defines output method for the view model. It is used by view model to send data updates to view.
<p><em>ViewModelInput</em> and <em>ViewModelOuput</em> protocols are used for communication between view and view model while providing loose coupling.</p>
* **View/ViewController:** It contains code to create and update view. View implements <em>ViewModelOutput</em> to receive data updates from view model. It also contains an instance of a view model to update data according to user actions.
* **ViewModel:** It stores data and manages operations on data. It contains instance of repository to fetch and manage data. It also contains reference to view to send updates when data is changed.
* **ViewComposer:** View Composer contains a single make method which initialize view, view model and communication between them. It is used by router to initialize view controllers.

### <a id="thirdparty-dependencies">ThirdParty Dependencies</a>
This project uses following thirdparty libraries

* **[ApiClient](https://github.com/mansoor92/ApiClient)** 
* **[IQKeyboardManagerSwift](https://github.com/hackiftekhar/IQKeyboardManager)** 
* **[Reusable](https://github.com/AliSoftware/Reusable)** 
* **[Toast](https://github.com/scalessec/Toast-Swift)** 
