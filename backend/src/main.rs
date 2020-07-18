// use actix_files::Files;
// use actix_web::{get, middleware, web, App, HttpResponse, HttpServer};
// use tracing;
// use tracing_subscriber;

// use shared_lib;

// #[get("/add/{a}/{b}")]
// async fn add(to_add: web::Path<(u32, u32)>) -> HttpResponse {
//     HttpResponse::Ok().json(shared_lib::add(to_add.0, to_add.1))
// }

// #[get("/movies")]
// async fn movies() -> HttpResponse {
//     HttpResponse::Ok().json(shared_lib::get_movies())
// }

// #[actix_rt::main]
// async fn main() -> std::io::Result<()> {
//     let _subscriber = tracing_subscriber::fmt()
//         .with_max_level(tracing::Level::INFO)
//         .init();

//     HttpServer::new(|| {
//         App::new()
//             .wrap(middleware::Logger::default())
//             // API
//             .service(add)
//             .service(movies)
//             // UI
//             .service(Files::new("/", "./web/").index_file("index.html"))
//     })
//     .bind("0.0.0.0:8080")?
//     .run()
//     .await
// }

use actix_files::Files;
use actix_web::{get, middleware, web, App, HttpResponse, HttpServer};

#[actix_rt::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| App::new().service(Files::new("/", "./web/").index_file("index.html")))
        .bind("0.0.0.0:8080")?
        .run()
        .await
}
