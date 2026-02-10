# Mobile App Development Class: Assignment Setup

Welcome to the mobile app development class! This repository will hold the weather app which we will be working on each class. 
Follow the steps below to set up your environment, complete your assignments, and submit your work for review.

## Step 1: Log in to GitHub

Before you begin, make sure you are logged in to your GitHub account. If you don't have a GitHub account yet, [create one here](https://github.com/join).

## Step 2: Fork the Repository

1. Go to the main repository URL:  
   [https://github.com/danwhite-osucascades/cs492-weather-app.git](https://github.com/danwhite-osucascades/cs492-weather-app.git)

2. In the top-right corner, click the **Fork** button to create a copy of the repository under your own GitHub account.  
   - This will create a forked version of the repository that you can modify without affecting the original repository.

## Step 3: Clone Your Fork to Your Local Machine

1. **Navigate to a directory** on your local machine where you want to store the repository. You can use the terminal to move to that directory. For example:
   ```bash
   cd ~/Documents/Projects
   ```

2. **Clone the repository**
  ```bash
  git clone https://github.com/YOUR_USERNAME/cs492-weather-app.git  
  ```

**replace with your own user name**

3. **Navigate to the new repository**
  ```bash
   cd cs492-weather-app
  ```

## Step 4: Set Up the Upstream Repository
1. **Add the original repository (this one) as a remote to keep your fork updated with the changes that we make**
  ```bash
   git remote add upstream https://github.com/danwhite-osucascades/cs492-weather-app.git
  ```

2. **Fetch the latest changes**
  ```bash
     git fetch upstream
  ```

## Step 5: Completing Assignments

Each week, during class, there will be in-class assignments. These will be held under specific branch names (i.e. assignment1-1)

To complete the assignments, you'll need to check out that branch, complete the TODOs, stage, commit, and push those changes to your own remote repository.

The following example is specific to *assignment1-1*. You will be given a new branch each class, so changes *assignment1-1* to that branch name and follow the instructions below:

1. **Checkout main branch**

It is good practice to checkout back to main before fetching changes and creating new branches.
  ```bash
     git checkout main
  ```

2. **Fetch the latest changes**
   
As mentioned above, you'll need to fetch the latest changes each time as the branches will be pushed to the professor's repo prior to each class.
  ```bash
     git fetch upstream
  ```

3. **Merge the upstream main into your repo's main**
  ```bash
     git merge upstream/main
  ```

4. **Checkout the assignment-specific branch**
  ```bash
    git checkout -b assignment1-1 upstream/assignment1-1
  ```

5. **Install dependencies and run the app**

Be sure you select a device by clicking in the lower right corner of VSCode where it may say "No Device" to drop down available devices, and choose the android/iphone device that you set up.

Install dependencies:

```bash
   flutter pub get
```

Run flutter:

```bash
  flutter run
```

5. **Complete the TODOs**

Look through the assignment and complete all of the TODOs for that assignment.

6. **Stage Changes**
It should be safe to stage all changes (unless you made changes to files outside of the scope of the assignment)
  ```bash
     git add *
  ```

7. **Commit Changes**
  ```bash
     git commit -m "Completed work for assignment1-1"
  ```

8. **Push changes to your repository**
  ```bash
     git push origin assignment1-1
  ```

9. **Submit a link to your branch**
   
Verify that the assignment branch was pushed to your remote repository with your changes. Copy a link to your branch and submit it for that assignment on canvas.
