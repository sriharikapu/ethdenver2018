<template>
  <div id="header-template" class="sticky header">
    <div class="content">
      <router-link to="/" class="logo"></router-link>
      <div class="links">
        <router-link to="/sign-up" class="link1" v-if="!user.isLoggedIn">Sign Up</router-link> <span v-if="!user.isLoggedIn" class="divider"></span>
        <input type="button" class="link1" v-if="!user.isLoggedIn" value="Login" @click="logUserIn"> <span v-if="!user.isLoggedIn" class="divider"></span>
        <router-link to="/profile/edit" class="link2" v-if="user.isLoggedIn">Edit Profile</router-link> <span v-if="user.isLoggedIn" class="divider"></span>
        <input type="button" class="link2" v-if="user.isLoggedIn" value="Logout" @click="logUserOut">
      </div>
    </div>
  </div>
</template>

<script type="text/javascript">
  export default {
    name: 'header-template',
    methods: {
      ...mapActions([
        ACTION_TYPES.LOGIN,
        ACTION_TYPES.LOGOUT
      ]),
      logUserIn (evt) {
        evt.target.disabled = true
        if (!this.user.isLoggedIn) {
          Auth.login(this.$store.state)
          .then((userData) => {
            this[ACTION_TYPES.LOGIN](userData)
            .then((userData) => {
              evt.target.disabled = false
              if (!this.user.isLoggedIn) {
                this.$router.push('/')
              } else {
                this.$router.push('/dashboard')
              }
            })
            .catch((err) => {
              evt.target.disabled = false
              console.error(err)
            })
          })
          .catch((err) => {
            evt.target.disabled = false
            console.error(err)
          })
        } else {
          evt.target.disabled = false
        }
      },
      logUserOut (evt) {
        evt.target.disabled = true
        this[ACTION_TYPES.LOGOUT]()
        .then(() => {
          evt.target.disabled = false
          this.$router.push('/')
        })
      }
    },
    props: [ 'user' ]
  }

  import { mapActions } from 'vuex'
  import Auth from '../../js/Auth'
  import { ACTION_TYPES } from '../../util/constants'
</script>

<style scoped>
  #header-template {
    width: 100%;
  }

  .sticky {
    position: fixed;
    padding: 5px 20px;
    top: 0px;
    height: 70px;
    width: 100%;
    box-sizing: border-box;
    z-index: 666;
    border-bottom: 1px solid #666666;
  }

  .content {
    height: 60px;
    line-height: 60px;
  }

  .logo {
    float: left;
    width: 250px;
    height: 36px;
    background-size: contain;
    margin: 15px 0px;
    text-decoration: none;
    background: url('/static/images/Lockup-alt.png') no-repeat;
    background-size: contain;
  }

  .links {
    float: right;
    height: 60px;
  }

  .links:before {
    content: '|||||';
    color: #dcdede;
    position: absolute;
    right: 20px;
    height: 20px;
    line-height: 20px;
    top: 40px;
  }

  .links:hover a {
    display: block;
  }

  .links a {
    display: none;
    width: 150px;
    height: 50px;
    line-height: 50px;
    font-size: 14px;
    color: #bababa;
    text-decoration: none;
    text-align: center;
    border-bottom: 1px solid #dcdede;
    background: #efefef;
    position: absolute;
    right: 20px;
  }

  .links a:last-child {
    border: none;
  }

  .links a:hover {
    background: #dcdede;
    color: #feffff;
  }

  .link1 {
    top: 60px;
  }

  .link2 {
    top: 110px;
  }

  .link3 {
    top: 160px;
  }

  .link4 {
    top: 210px;
  }

  .divider {
    display: none;
  }

  @media only screen and (min-width: 780px) {
    .links:before {
      display: none;
    }

    .links:hover a {
      display: inline-block;
    }

    .links a:hover {
      background: transparent;
      color: #4c4e49;
    }

    .links a {
      display: inline-block;
      width: auto;
      margin-top: 5px;
      color: #4c4e49;
      border: none;
      position: relative;
      top: 0px;
      background: transparent;
      right: 0px;
    }

    .divider {
      color: #4c4e49;
      display: inline-block;
    }

    .divider:before {
      content: "|";
    }
  }
</style>
