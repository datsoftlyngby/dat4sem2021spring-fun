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
                call.respondText("Hello ${System.nanoTime()}")
                }
            }
        }.start(wait = true)
    }