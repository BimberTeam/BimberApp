[![Commit badge](https://img.shields.io/github/last-commit/BimberTeam/BimberApp)](https://github.com/BimberTeam/BimberApp/commits/master)
[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/dwyl/esta/issues)
[![HitCount](http://hits.dwyl.com/BimberTeam/BimberApp.svg)](http://hits.dwyl.com/BimberTeam/BimberApp)

# Bimber :beers:
*Check the app your yourself by simply downloading an apk file and installing it on your android device: https://github.com/BimberTeam/BimberApp/releases/download/1.0/app.apk*

## Team  :punch:
<table align="center">
  <tr>
   <td align="center"><a href="https://github.com/jmysliv"><img src="https://avatars1.githubusercontent.com/u/48885911?s=460&v=4" width="100px;" alt=""/><br /><sub><b>Jakub Myśliwiec</b></sub></a></td>
    <td align="center"><a href="https://github.com/Qizot"><img src="https://avatars0.githubusercontent.com/u/34857220?s=400&u=594645f4b7548bb57393509b17a031e88f04d81c&v=4" width="100px;" alt=""/><br /><sub><b>Jakub Perżyło</b></sub></a></td>
   <td align="center"><a href="https://github.com/skusnierz"><img src="https://avatars2.githubusercontent.com/u/47144579?s=460&v=4" width="100px;" alt=""/><br /><sub><b>Sebastian Kuśnierz</b></sub></a></td>
    </tr>
</table>

## About project :question:
***Have you ever felt the need to met new peoples that love the same type of alcohol as you? Peoples, that like to party the exact same way as you? Now Bimber makes meeting those people possible.***


Bimber is a tinder-like app in which you can instead of searching for love search for parties and drinking. You can discover new people by swiping them just like in Tinder but what's different is when you match with another person, you form a party group. It means that other thirsty souls can discover you as a group so more people can party together. You can accept or reject potential party-goers in a dedicated view, it works like voting - if 50% of the group members accept the candidate, he's in. You can add people you discovered to your friends' list with whom you can later create a new group or simply invite them to an existing group. We also implemented a well-known feature you may recall from Snapchat  - a localization map. It helps users to see where they currently are so they can meet together. Just like in Snapchat stories, each group exists for a limited time. Make sure you get in touch with people you like as after 4 days all group history will be gone forever. 

### What we learned
During working on that project we learned a lot about team cooperation. We often work simultaneously on the same code base so we have to develop good task management. Luckily GitHub had a great tool for that (Projects). As we worked in a team, we learned how important it is to write clean and readable code, so other team members could easily understand it. At the end it turned out that creating app with team is way more exciting cause you can discuss every ideas together and work out the best solution.

## Technology stack :computer: 
### Backend
Full description of backend technologies is available [here](https://github.com/BimberTeam/Bimber)
### Frontend
To develop a mobile application we went for the multiplatform framework **Flutter**. As our team created flutter apps before, we tried to focus on developing some more complex views. During creating UI we tried to imitate Tinder views, to make our app as similar as possible. However as our app introduces features that aren't available on Tinder, some views are completely our ideas. For state management, we went for the **BLoC pattern** which is great to separate business logic from presentation. Together with our team, we decided to use **GraphQL** to develop an API. So to communicate with our backend server we went for **graphql_flutter** library.

## Get Started :fire:

Right now backend server is deployed on DigitalOcean so all you have to do to start using app is to download it from [here](https://github.com/BimberTeam/BimberApp/releases/download/1.0/app.apk).

If you want to test the app locally here is quick guide:

Make sure you have installed:
* Docker
* Docker-compose
* Flutter

Then just copy and paste the following commands to run server:
```bash
git clone git@github.com:BimberTeam/Bimber.git
cd Bimber
docker-compose up
```
Then you have to modify server url in mobile app. Firstly clone repository using the following command:
```bash
git clone git@github.com:BimberTeam/BimberApp.git
```
Next open [.env_prod file](bimber/assets/env/.env_prod) and edit it replacing DigitalOcean server ip with your own ip. Then you can build and install your app on your mobile device using the following commands:

```bash
cd BimberApp/bimber
flutter build apk --split-per-abi
flutter install
```

## Frontend demo :iphone:
Here you can se demo of most features our app offers
### Discovering new peoples and groups

![discover](gifs/discover.gif)

![match](gifs/match.gif)

### Accepting friend/group requests

![accept](gifs/friend-accept.gif)

### Chatting with your matches

![chat](gifs/chat.gif)

### checking group info and map

![group-info](gifs/group-info.gif)

### Voting on new group members

![voting](gifs/voting.gif)

### Adding friends to group

![add-friends](gifs/add-friends.gif)

### Creating new group from friends

![create-group](gifs/create-group.gif)

### Editing your account

![edit-account](gifs/edit-account.gif)
