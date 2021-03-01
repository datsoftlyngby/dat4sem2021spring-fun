package dk.cphbusiness.`fun`

import io.ktor.application.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*

fun main() {
    embeddedServer(Netty, port = 4711) {
        routing {
            get("/") {
                call.respondText("Hello")
                }
            }
        }.start(wait = true)
    }