# Toilet Bowling

## Backstory

*This is displayed to the player, scrolled like starwars or something.*

You are a phenomenal inventor. While preparing to test your amazing shrinking
ray on a full size boat, your 2 year old child accidentally activated it. Both
you and the boat are now smaller than a toy. But that's not the worst part...

Your child decided to put you in the toilet and flush it. And now is throwing
more toys to watch it all go down the drain. Will you be able to last long
enough for the shrinking ray to wear off?


## Assets Needed

- Theme intro music (shown during the backstory scrolling effect, Future Crew soundtrack?)
- Action music (during gameplay, Future Crew soundtrack?)
- Flushing sound (for beginning of gameplay)
- Game over scene (lists the score, maybe keeps track of a high-score)
- About scene
- Boat image
- Black hole drain image
- Toy images (maybe 10?) [From Vectors.me][vm]
- Damage sound effect

  [vm]: https://github.com/jonathanpenn/ToiletBowling

## Game Mechanics

- Stay alive as long as you can (timer with milliseconds indicates score)
- Health meter, bumping into objects depletes health
- Fall down the drain is instant death
- Everything is swirling around the center drain
- Use parallaxed swirls to indicate water motion
- Toys appear at random around the edges and swirl toward the center
- As time increases, toys appear at a much higher frequency
- Toys can bump into each other and respond with somewhat elastic collisions
- Boat is pulled towards the drain. TODO: controls for the boat? Finger or a set of control pads?

### Boat Mechanic Discussion

[jp] Brain Dump: I'm imagining where you touch your finger and it draws the
boat to you at a constant velocity. If you let go, then it drifts toward the
drain. The drain isn't a risk, then, while your finger is on the screen. The
challenge comes from avoiding the swirling toys. Thoughts?


## Credits

Game by Jonathan Penn (@jonathanpenn), Michele Titolo (@micheletitolo), Tom Maes (@tmaes)

Intro music lovingly ripped from Future Crew's [Second Reality Demo][sr], Copyright October 1993.

  [sr]: http://en.wikipedia.org/wiki/Second_Reality

- [Purple Motion's Action Scene](http://modarchive.org/index.php?request=view_by_moduleid&query=60400)
- [Skaven's Intro](http://modarchive.org/index.php?request=view_by_moduleid&query=60395)
- [Vectors.me][vm]
