import { createApp, registerElement } from "nativescript-vue";
import { SwiftUI } from "@nativescript/swift-ui";
import Home from "./components/Home.vue";

registerElement("SwiftUI", () => SwiftUI);

import BottomNavigationBar from "@nativescript-community/ui-material-bottomnavigationbar/vue";

const app = createApp(Home);

app.use(BottomNavigationBar);
app.start();
