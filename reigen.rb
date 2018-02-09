# -*- coding: utf-8 -*-

Plugin.create(:reigen) do

  def create_body(name, uri)
    "ｽｩｯ… #{name}です… #{uri}"
  end

  compose_proc = Proc.new do |world, message|
    compose(world, body: create_body(message.user.name, message.uri))
  end

  do_nothing = Proc.new do end
  pred_true  = -> (world, message) { true }
  pred_false = -> (world, message) { false }

  # 危険なので封印
  #defspell(:share, :worldon_for_mastodon, :twitter_tweet, condition: pred_true, &compose_proc)
  #defspell(:shared, :worldon_for_mastodon, :twitter_tweet, condition: pred_false, &do_nothing)
  #defspell(:share, :twitter, :worldon_status, condition: pred_true, &compose_proc)
  #defspell(:shared, :twitter, :worldon_status, condition: pred_false, &do_nothing)

  command(:reigen,
          name: _("霊言する".freeze),
          condition: -> (opt) {
            world, = Plugin.filtering(:world_current, nil)
            t2m = world&.class&.slug == :twitter && opt.messages.any? {|m| m.class.slug != :twitter_tweet}
            m2t = world&.class&.slug == :worldon_for_mastodon && opt.messages.any? {|m| m.class.slug != :worldon_status}
            t2m || m2t
          },
          visible: true,
          role: :timeline) do |opt|
    world, = Plugin.filtering(:world_current, nil)
    message_slug = world.class.slug == :worldon_for_mastodon ? :worldon_status : :twitter_tweet
    targets = opt.messages.select{|m| m.class.slug != message_slug }
    targets.each do |m|
      compose_proc.call(world, m)
    end
  end
end
