# Shelf Guardian

## Description

Introducing **Shelf Guardian**, your ultimate solution for managing product durability and inventory efficiently. With Shelf Guardian, you can ensure that your products are always fresh and well-managed. Here's what Shelf Guardian offers:

- **Track Minimum Durability Dates**: Monitor your products' expiration dates effortlessly. Shelf Guardian keeps an updated record of all your products' minimum durability dates.
- **Comprehensive Inventory Management**: Easily add, remove, or update product information. Maintain a well-organized and current inventory with just a few clicks.
- **Barcode Recognition**: Speed up your inventory process with our barcode scanning feature. Instantly add products to your inventory by scanning their barcodes.
- **Smart Notifications**: Stay informed with timely notifications on your phone when products are nearing their minimum durability dates. Prevent waste and ensure your products are always fresh.

**Shelf Guardian** – safeguarding your shelves and keeping your products fresh and organized!

## Features

### Authentication

Products are assigned to users, so before anyone can add products, they must create an account and sign in.

- **Sign In Page**: This is the start page when someone opens the app for the first time or if no valid authentication token is stored. Authentication tokens are invalidated once they expire.

  ![Sign In](./docs/pages/auth/sign-in-page.png)

- **Sign Up Page**: Accessible when the user clicks on "Registrieren." Here, users can create an account, but they must verify it through a verification email from Supabase before using the app.

  ![Sign Up](./docs/pages/auth/sign-up-page.png)

- **Forgot Password Page**: If a user forgets their password, they can recover their account. Supabase will send a recovery email allowing the user to reset their password.

  ![Forgot Password](./docs/pages/auth/forgot-password.png)

### Manage Products

#### Overview of Your Products

If you have a valid session, you can view your products. The start page displays all your products, sorted by their expiration dates, with those expiring soonest at the top. If no products are listed, you will see `Keine Produkte gefunden`.

You can select one or multiple products from the list to remove. To select a product, long-click on it. Once selected, you can add or remove other products with a short click. Alternatively, use the checkboxes next to each item to select or deselect them with a short click. Selected items will have a checked box, while unselected items will have an empty checkbox.

When a product is selected, the action buttons change. The main button in the center becomes the delete button for the selected items. The button on the right allows you to deselect items. If no items are selected, the main button adds a new product, and the right button selects all products.

- **Nothing selected** :

  ![Home Page](./docs/pages/home-page.png)

- **Items selected**:

  ![Selected](./docs/pages/selected-page.png)

#### Add a New Product

To add a new product, click the `+` button in the bottom right corner. This takes you to the `Scanner` page, where you can scan the product's barcode. If the barcode is not recognized, you can manually enter the product information. If recognized, the product information is filled in automatically, and you only need to enter the minimum durability date.

> Recognized barcodes mean the product is already in the database with its name filled in. If the barcode is not recognized, you must enter the name manually. The minimum durability date and price must be entered manually each time.

After scanning, you are taken to the `Create` page to enter the minimum durability date. Once all information is entered, click the save button to save the product. To cancel, click the cancel button or scan another barcode.

Once saved, you are redirected back to the `Home` page, where your new product appears in the list. If you have another device with the same account, the new product will be synchronized to it via Supabase Realtime Database.

- **Scanner Page**:

  <img src="./docs/pages/scanner-page.png" alt="Scanner Page" width="340"/>

- **Create Page**:

  ![Create Page](./docs/pages/create-page.png)

#### Update a Product

To update a product, click on it in the list. This navigates to the `Update` page, where you can update the minimum durability date, name, price, and other details. After making changes, click the save button to save the product. To cancel, click the cancel button.

After saving, you are redirected back to the `Home` page, where the updated product appears in the list. Any device with the same account will receive the updated product.

![Update Page](./docs/pages/update-page.png)

#### Delete a Product

To delete a product, select it from the list. This changes the action buttons, making the main button in the center the delete button for the selected items. Click the delete button to remove the selected products. To cancel, click the deselect button.

### Filter and Search Products

#### Filter Products

You can filter products using various criteria. The filter button, which is the second button in the action list on the `Home` page, opens the `Filter` page when clicked. On the `Filter` page, select your desired criteria and click the apply button (save icon) to filter the products. To cancel, click the cancel button or the back button.

The applied filter is saved in the local storage, so you don't need to reapply it every time you open the app. To remove the filter, click the filter button again and select the left button (filter icon with a times icon).

![Filter Page](./docs/pages/filter-page.png)

#### Search Products

If you have many products and need to find a specific one, you can use the search function. Click the last button in the action list, which has a magnifying glass icon, to open the `Search` bar. Enter the name of the product you are looking for. The search is case-insensitive and looks for the entered text within the product names. If the product is found, it will be highlighted in the list. If not, a message will display stating that no product was found.

![Search Bar](./docs/pages/search-bar.png)

### Recognize Existing Barcode

When you scan a barcode, the app checks in the background to see if the barcode is already in the database. If it is, the product information will be automatically populated. If the barcode is not recognized, you will need to manually enter the product details, such as the name, description, and minimum durability date.

Additionally, if you update the name of a product, all products with the same barcode will be notified of the change. This ensures that any name update is applied universally to all products sharing that barcode, keeping your inventory consistent.

### Notifications

Shelf Guardian sends daily notifications to your device for products that are about to expire. These notifications are sent at 8:00 AM and will list all products expiring either on that day or the following day. If there are no products nearing expiration, no notification will be sent, ensuring you only receive relevant alerts.

### Synchronization

Shelf Guardian ensures real-time synchronization across all devices linked to the same account. Any changes made on one device, such as adding, updating, or deleting a product, are instantly reflected on all other devices. This allows you to seamlessly manage your inventory from multiple devices without worrying about data discrepancies.

### Easter Egg

For a fun surprise, scan the QR code below. It will take you to the YouTube video [Rick Astley - Never Gonna Give You Up](https://www.youtube.com/watch?v=dQw4w9WgXcQ), playing the iconic song. This playful Easter egg is our way of adding a bit of fun to your experience with Shelf Guardian.

<img src="./docs/egg.jpeg" alt="Easter Egg" width="240"/>

## Technologies

### Dependencies

### Permissions

### Problems during development

## Future
