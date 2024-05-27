import app/models/item.{type Item}
import lustre/element.{type Element, text}
import lustre/element/html.{h1}

pub fn root(items: List(Item)) -> Element(t) {
  h1([], [text("Homepage")])
}
