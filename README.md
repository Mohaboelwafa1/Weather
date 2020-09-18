# Weather
MVVM Pattern used: MVVM
Swift version: 5.
iOS target: 13.
Languages : En , Du.

Most of applications are based on the Model-View-Controller pattern (MVC). MVC is easy to understand , but it isn't perfect. The Model-View-ViewModel pattern offers a better way to organise the application.

In a project built with the MVC pattern, there is a question like from where is going where?!. Code that doesn’t fit the model or view layer is put in the controller. This leads to massive controllers that are difficult to test and manage.

The MVVM pattern presents a better separation of concerns by adding view models. The view model translates the data of the model layer into something the view layer can use. The controller is no longer responsible for this task.

View controllers are hard to test because of their relation to the view layer. The view model doesn’t have a reference to the object it is owned by.

The view controller no longer depends on the model layer, which makes them easier to test.

Responsibilities of the view controller are reduced to controlling the interaction between the view layer and the model layer, glueing both layers together.

We can group some point like following:
1 - The view does not know about the controller it is owned by. Just present the data.
2 - The controller does not know about the model.
3 - The model does not know about the view model it is owned by.
4 - The view model owns the model.
5 - The view controller owns the view.
6 - The controller owns the view model.

