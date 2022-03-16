import { createActor, microblog } from "../../declarations/microblog";

async function post() {
  let post_button = document.getElementById("post_btn");
  post_button.setAttribute("disabled", true);
  const opt_input = document.getElementById("opt");
  const message_input = document.getElementById("message");
  try {
    await microblog.post(opt.value, message.value);
  } catch (e) {
    console.log(e);
  }
  post_button.removeAttribute("disabled");
  opt_input.value = "";
  message_input.value = "";
}

async function load_post(e) {
  let actor = createActor(e.target.getAttribute("principal"));
  const posts = await actor.posts(new Date().getTime());
  const postsUI = document.getElementById("posts_user");
  postsUI.replaceChildren([]);
  for (let i = 0; i < posts.length; i++) {
    const post = document.createElement("div");
    const timestamp = new Date();
    timestamp.setTime(Number(posts[i].time) / 1000000);
    let author = posts[i].author;
    if (author == "") {
      author = "NoName";
    }
    post.innerHTML = `<p>${posts[i].text}</p><span>${author} Post at ${timestamp.toLocaleTimeString()}<span>`;
    postsUI.appendChild(post);
  }
}

async function load_data() {
  const now = new Date().getTime();
  const posts = await microblog.posts(now);
  const postsUI = document.getElementById("posts");
  if(postsUI.childElementCount !== posts.length) {
    postsUI.replaceChildren([]);
    for (let i = 0; i < posts.length; i++) {
      const post = document.createElement("div");
      const timestamp = new Date();
      timestamp.setTime(Number(posts[i].time) / 1000000);
      let author = posts[i].author;
      if (author == "") {
        author = "NoName";
      }
      post.innerHTML = `<p>${posts[i].text}</p><span>${author} Post at ${timestamp.toLocaleTimeString()}<span>`;
      postsUI.appendChild(post);
    }
  }


  const follows = await microblog.follows();
  const followsUI = document.getElementById("follows");
  if(followsUI.childElementCount !== follows.length) {
    followsUI.replaceChildren([]);
    for (let i = 0; i < follows.length; i++) {
      let actor = createActor(follows[i]);
      let name = await actor.get_name();
      if (name == "") {
        name = "NoName";
      }
      const follow = document.createElement("div");
      follow.setAttribute("principal", follows[i]);
      follow.onclick = load_post;
      follow.innerHTML = name;
      followsUI.appendChild(follow);
    }
  }

  const timelineUI = document.getElementById("timeline");
  timelineUI.replaceChildren([]);
  for (let j = 0; j < follows.length; j++) {
    const follow = follows[j];
    const actor = createActor(follow);
    const timeline = await actor.posts(now);
    for (let i = 0; i < timeline.length; i++) {
      const post = document.createElement("div");
      const timestamp = new Date();
      timestamp.setTime(Number(timeline[i].time) / 1000000);
      let author = timeline[i].author;
      if (author == "") {
        author = "NoName";
      }
      post.innerHTML = `<p>${timeline[i].text}</p><span>${author} Post at ${timestamp.toLocaleTimeString()}<span>`;
      timelineUI.appendChild(post);
    }
  }
}

function load() {
  let post_button = document.getElementById("post_btn");
  post_button.onclick = post;
  load_data();
  setInterval(load_data, 3000);
}

window.onload = load;
