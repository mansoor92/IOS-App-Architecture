![iOS App Architecture](https://github.com/mansoor92/IOS-App-Architecture/blob/main/logo.png)

iOS App Architecture is designed to provide a structured approach and loosely coupled code using familiar design patterns. It aims to establish a solid foundation for iOS development, allowing developers to quickly set up projects, enable fast-paced development and focus on building robust and scalable applications.

## Components

1. [Data Layer](#data)
2. [Dependency Container](#dependency-container)
3. [Router](#router)
4. [UI Layer with MVVM](#ui-layer)
5. [Third-Party Dependencies](#thirdparty-dependencies)

### <a id="data">Data Layer</a>
The Data Layer is responsible for managing local and remote data within the application. It follows the repository pattern, utilizing protocols and the factory pattern for flexible and decoupled data management. The key components of the Data Layer include:

* **Repositories:** Repositories define protocols that act as blueprints for data management. Concrete classes implement these protocols, providing the actual implementation details. A factory class is used to create instances of repositories, hiding the concrete classes from the clients.
* **Store:** If both local and remote data need to be managed, separate Local and Remote classes are defined. These classes implement the repository protocols and are managed by a store, which also conforms to the repository protocol.
* **Models:** Models are typically defined as structs, representing the data models for REST APIs or persistence storage.
* **RequestModel:** It provides the implementation of the network layer. Currently, the project uses the lightweight Swift package [Api Client](https://github.com/mansoor92/ApiClient) for network requests. However, you can easily replace it with any other networking library without making changes to the repositories.

### <a id="dependency-container">Dependency Container</a>
The Dependency Container manages all the dependencies within the application. It holds instances of the Request Model, Persistence Storage, and repositories. It is initialized in the SceneDelegate of the application, ensuring proper dependency injection throughout the app.

### <a id="router">Router</a>
The Router handles the navigation flow within the application. It is responsible for initializing view controllers and displaying them on the screen based on user actions or events.

### <a id="ui-layer">UI Layer with MVVM</a>
The UI Layer follows the MVVM (Model-View-ViewModel) pattern, separating the code responsible for creating views and managing their associated business logic. The key components of the UI Layer include:

* **ViewModelInput<Protocol>:** This protocol defines input methods for the view model, allowing the view to send events or user interactions to the view model.
* **ViewModelOutput<Protocol>:** This protocol defines output methods for the view model, enabling the view model to send data updates or state changes to the view.
  The ViewModelInput and ViewModelOutput protocols facilitate communication between the view and the view model, ensuring loose coupling and separation of concerns.
* **View/ViewController:** The view or view controller is responsible for creating and updating the view. It implements the ViewModelOutput protocol to receive data updates from the view model. Additionally, it holds an instance of the view model to handle user interactions and update the data accordingly.
* **ViewModel:** The view model stores data and manages the operations related to that data. It contains a reference to the repository for fetching and managing data. The view model communicates with the view through the ViewModelOutput protocol to provide updates when the data changes.
* **ViewComposer:** The View Composer is a helper class that provides a single make method for initializing the view, view model, and establishing communication between them. It is used by the router to initialize view controllers.

### <a id="thirdparty-dependencies">Third-Party Dependencies</a>
The project utilizes the following third-party libraries for enhanced functionality:

* **[ApiClient](https://github.com/mansoor92/ApiClient):** A lightweight Swift package used for network requests.
* **[IQKeyboardManagerSwift](https://github.com/hackiftekhar/IQKeyboardManager):** A library that simplifies keyboard handling and provides a seamless typing experience.
* **[Reusable](https://github.com/AliSoftware/Reusable):** A library that enhances code reusability by providing a protocol-based approach for handling reusable views and cells.
* **[Toast](https://github.com/scalessec/Toast-Swift):** A library for displaying toast notifications, providing visual feedback to users.