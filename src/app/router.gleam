import app/pages
import app/pages/layout.{layout}
import app/web.{type Context}
import gleam/string_builder
import lustre/element
import wisp.{type Request, type Response}

pub fn handle_request(req: Request, ctx: Context) -> Response {
  use _req <- web.middleware(req, ctx)
  wisp.html_response(string_builder.from_string("Hello, World!"), 200)

  case wisp.path_segments(req) {
    // homepage
    [] -> {
      [pages.home()]
      |> layout
      |> element.to_document_string_builder
      |> wisp.html_response(200)
    }

    // error responses
    ["internal-server-error"] -> wisp.internal_server_error()
    ["unprocessable-entity"] -> wisp.unprocessable_entity()
    ["method-not-allowed"] -> wisp.method_not_allowed([])
    ["entity-too-large"] -> wisp.entity_too_large()
    ["bad-request"] -> wisp.bad_request()
    _ -> wisp.not_found()
  }
}
