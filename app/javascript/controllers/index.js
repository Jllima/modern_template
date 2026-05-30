import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import UiController from "./ui_controller"
application.register("ui", UiController)

import CounterController from "./counter_controller"
application.register("counter", CounterController)
