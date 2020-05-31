# Reactor

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Schemas

mix phx.gen.html Accounts User users name email is_verified:boolean password_hash website

yes | mix phx.gen.html Content Podcast podcasts audio_url is_published:boolean notes_md:text subtitle title:unique

yes | mix phx.gen.html Content Comment comments is_published:boolean is_flagged:boolean html:text markdown:text podcast_id:references:podcasts user_id:references:users

yes | mix phx.gen.context Content Topic topics name:unique

yes | mix phx.gen.context Content PodcastTopic podcast_topics podcast_id:references:podcasts topic_id:references:topics

## Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://hexdocs.pm/phoenix/overview.html
* Docs: https://hexdocs.pm/phoenix
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix
