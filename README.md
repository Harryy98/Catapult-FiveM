# ✈️ FiveM Catapult Launch System

This script allows players to set their aircraft on a catapult and launch from it using realistic acceleration. Perfect for aircraft carrier RP or military servers.

---

## 🚀 Features

- Set your aircraft on a nearby catapult using `/catapultset`
- Launch the aircraft using `/catapultlaunch` with boost and FX
- Custom notifications powered by `ox_lib`
- Works with aircraft carriers or any map with configured coordinates
- Automatic landing gear deployment post-launch

---

## ⚙️ Setup

### 1. Add the Script

- Drop the files into a folder like `Catapult-FiveM` inside your `resources` directory.

### 2. Add to `server.cfg`

```cfg
ensure ox_lib
ensure Catapult-FiveM
```

---

## 🧠 Commands

### `/catapultset`
Detects your closest catapult and positions your aircraft correctly.

### `/catapultlaunch`
Launches your aircraft from the last set catapult with speed and effects.

---

## ✏️ Customization

In `client.lua`:

- **Edit Catapult Positions**  
  Update the `catapultCoords` arrays for both commands with your custom positions.

- **Adjust Launch Speed**  
  Change `takeoffSpeed` and `slowdownSpeed` in the `/catapultlaunch` command.

- **FX/Visuals**  
  Uses `StartScreenEffect("RaceTurbo")`, can be changed for custom FX.

---

## 🧪 Requirements

- `ox_lib`: Required for the `lib.notify` function.  
  👉 [Download ox_lib here](https://github.com/overextended/ox_lib)
