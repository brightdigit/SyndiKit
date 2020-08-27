import Plot
import Vapor

public struct ErrorPageMiddleware: Middleware {
  let htmlController: HTMLController

  public func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
    next.respond(to: request).flatMapAlways { result in
      let code: UInt
      let viewName: String
      let html: HTML
      let response: Response?
      do {
        let resp = try result.get()
        code = resp.status.code
        response = resp
      } catch {
        if let abort = error as? AbortError {
          code = abort.status.code
        } else {
          code = HTTPStatus.internalServerError.code
        }
        response = nil
      }
      switch (response, code) {
      case (_, 404):
        viewName = "404"
      case (let .some(response), 0 ..< HTTPStatus.badRequest.code):
        return response.encodeResponse(for: request)
      default:
        viewName = "500"
      }

      do {
        html = try htmlController.view(viewName)
      } catch {
        let body = "<h1>Internal Error</h1><p>There was an internal error. Please try again later.</p>"
        request.logger.error("Failed to render custom error page - \(error)")
        return body.encodeResponse(status: .internalServerError, for: request)
      }
      let status = response?.status ?? .internalServerError
      return html.encodeResponse(status: status, for: request)
    }
  }
}
