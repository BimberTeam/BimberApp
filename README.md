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
***Have you ever feel need to met new peoples that love the same type of alcohol like you? Peoples that like to party the exact way like you? Now Bimber makes meeting those people possible.***

Bimber is a tinder-like app in which you can instead of search for love, you search for party and drinking. You can discover new people by swiping them just like in Tinder but what's different when you matched with other user, you formed a party group. It means that other people can discover you as a group and swipe you. You can accept or reject new members in dedicated view, it works like voting - if 50% of group accepts new user he joins your group. You can also add users you discover to your friends so later form group from them or simply add them to an existing group. We added also feature known from snapchat - a localization map, that helps users meet together. However, remember every group exists only for certain amount of time, so don't delay your party time forever, cause you can lose party opportunity.

## Technology stack :computer: 

## Frontend demo :iphone:

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
Next open [.env_dev file](bimber/assets/env/.env_dev) and edit it replacing DigitalOcean server ip with your own ip. Then you can build and install your app on your mobile device using the following commands:

```bash
cd BimberApp/bimber
flutter build apk --split-per-abi
flutter install
```