OutlineViewBindings Finagler
============================
This app shows a simple bindings-based Outline View which allows you to drag and drop files into the view, and remove them from the view. It seems to demonstrate a feature/bug where, despite removing the items from the table (and from the underlying array), neither the underlying MDFiles nor the MDTreeNodes are deallocated. Analysis seems to show that they are being retained by the isa-swizzled NSKVONotifying\_MDAppController class (created on behalf of the bindings system).



