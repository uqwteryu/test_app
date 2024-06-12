# Flutter Project Checklist

## Objective

Ensure the app utilizes the provided JSON file, which contains essential item information such as ID, name, rarity, color, and image.

## Tasks

### 1. Integration of JSON Data

- Verify that the app accesses the JSON file for item information.
- Confirm consistent usage of JSON data for displaying item details.

### 2. Case Sensitivity

- Review and adjust the code to handle any case sensitivity issues within the JSON file.

### 3. Provider Adjustment

- Update the user provider to seamlessly accommodate the JSON data for efficient data management and state handling.

### 4. Case Opening Mechanism

- Revise the case opening functionality to align with the updated JSON data structure.

## JSON File Format

    {
      "id": "skin-2162732",
      "name": "MP7 | Skulls",
      "rarity": {
        "id": "rarity_rare_weapon",
        "name": "Mil-Spec Grade",
        "color": "#4b69ff"
      },
      "paint_index": "11",
      "image": "https://raw.githubusercontent.com/ByMykel/counter-strike-image-tracker/main/static/panorama/images/econ/default_generated/weapon_mp7_hy_skulls_light_png.png"
    }
