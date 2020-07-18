use serde::Serialize;
use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn add(a: u32, b: u32) -> u32 {
    a + (b * 2)
}

#[wasm_bindgen]
#[derive(Serialize)]
pub struct Movie {
    title: String,
    description: String,
    pub rating: f32,
}

#[wasm_bindgen]
impl Movie {
    #[wasm_bindgen(getter)]
    pub fn title(&self) -> String {
        self.title.clone()
    }

    pub fn about(&self) -> String {
        format!("{} - {}", self.title.clone(), self.rating)
    }
}

#[wasm_bindgen]
pub fn get_movie() -> Movie {
    Movie {
        title: "A Great Movie".to_string(),
        description: "Description for the movie".to_string(),
        rating: 3.7,
    }
}

// `Vec<Movie>` can't go through the wasm border
// * It can be converted to an `Array` (or an `Array<Movie>` to keep inner type details) -> see `get_movies_array`
// * Or it can be converted to a `JsValue` using serde, in which case only data is transferred (with every serializable
//    field): field `description` is available in JS but not method `about` -> see `get_movies_js`
pub fn get_movies() -> Vec<Movie> {
    vec![
        Movie {
            title: "A Great Movie".to_string(),
            description: "Description for the movie".to_string(),
            rating: 3.7,
        },
        Movie {
            title: "Another movie".to_string(),
            description: "Meh".to_string(),
            rating: 2.0,
        },
    ]
}

use wasm_bindgen::JsCast;
#[wasm_bindgen]
extern "C" {
    #[wasm_bindgen(typescript_type = "Array<Movie>")]
    pub type MovieArray;
}
#[wasm_bindgen]
pub fn get_movies_array() -> MovieArray {
    get_movies()
        .into_iter()
        .map(JsValue::from)
        .collect::<js_sys::Array>()
        .unchecked_into::<MovieArray>()
}

#[wasm_bindgen]
pub fn get_movies_js() -> Result<JsValue, JsValue> {
    Ok(serde_wasm_bindgen::to_value(&get_movies())?)
}
