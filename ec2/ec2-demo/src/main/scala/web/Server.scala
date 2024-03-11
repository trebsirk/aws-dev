import zio._
import zio.http._

object DemoWebServer extends ZIOAppDefault {

  val app: HttpApp[Any] = 
    Routes(
      Method.GET / "text" -> handler(Response.text("Hello Scala Web Server Demo!"))
    ).toHttpApp

  override val run =
    Server.serve(app).provide(Server.default)
}