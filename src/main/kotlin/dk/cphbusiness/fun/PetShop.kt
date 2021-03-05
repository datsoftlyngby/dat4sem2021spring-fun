package dk.cphbusiness.`fun`

import io.ktor.application.*
import io.ktor.features.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*

fun main() {
    embeddedServer(Netty, port = 4711) {
        install(CORS) {
            anyHost()
            }
        routing {
            get("/") {
                Thread.sleep(500)
                call.respondText("""{ "greeting": "Hello ${System.nanoTime()}", "name": "Anders", "age": 61, "address": { "street": "Bygaden 7", "town": "Paris" } }""")
                }
            }
        }.start(wait = true)
    }