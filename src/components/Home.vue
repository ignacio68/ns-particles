<script lang="ts" setup>
  import { ref, computed, onMounted, onUnmounted, $navigateTo } from "nativescript-vue";
  import { registerSwiftUI, UIDataDriver, SwiftUI } from "@nativescript/swift-ui";
  import { TabSelectedEventData } from "@nativescript-community/ui-material-bottomnavigationbar";

  const mode = ref("simple");
  const modes = ["simple", "flipped"];
  let swiftUI: SwiftUI;

  interface ParticlesData {
    mode: string;
  }

  const data: ParticlesData = {
    mode: mode.value
  };

  onMounted(() => {
    console.log("onMounted");
  });

  function onLoaded(args) {
    swiftUI = args.object;
    console.log("Swift UI component Loaded", swiftUI);
  }

  function onBottomNavigationTabSelected(args: TabSelectedEventData) {
    mode.value = modes[args.newIndex];
    console.log("selected: ", mode.value);
    swiftUI.updateData({ mode: mode.value });
  }

  declare const ParticlesViewProvider: any;
  registerSwiftUI("particlesView", (view) => new UIDataDriver(ParticlesViewProvider.alloc().init(), view));
</script>

<template>
  <Frame>
    <Page>
      <ActionBar>
        <Label text="Particles" class="font-bold text-lg" />
      </ActionBar>

      <GridLayout rows="*, auto" class="container">
        <SwiftUI row="0" width="100%" height="100%" swiftId="particlesView" :data="data" @loaded="onLoaded" />
        <MDBottomNavigationBar row="1" activeColor="blue" inactiveColor="white" backgroundColor="black" selectedTabIndex="0" @tabSelected="onBottomNavigationTabSelected">
          <MDBottomNavigationTab title="SIMPLE" icon="" />
          <MDBottomNavigationTab title="FLIPPED" icon="" />
        </MDBottomNavigationBar>
      </GridLayout>
    </Page>
  </Frame>
</template>

<style scoped lang="scss"></style>
