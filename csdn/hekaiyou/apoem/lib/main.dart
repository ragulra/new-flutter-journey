import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'One Piece Poem',
      home: new Apoem(),
    )
  );
}

class Apoem extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('One Piece Poem'),
          centerTitle: true,
        ),
        body: new ListView(
          children: <Widget>[
            new Text(
              'One Piece Poem',
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 25.0,
                fontFamily: 'serif',              
              ),
            ),
            new Text('''
Once upon a time
There was on the Grand Line
Nine pirates on a ship
Hopping they won’t drip

On the East Blue the story began
Without any hurricane
Out a barrel jumped a boy
Punches a mans face with joy

He helped a boy with pink hair
Saving him seemed really fair
He knocked down a fat cow
And everyone was like WOW

A scar, rubber and a straw hat marked him
But doesn’t looked like he would go to gym
The pink hair guy helped him out
Roronoa Zoro would join without doubt
The Marine constrained him like Jesus Christ
For this Luffy gave the Captain a fist
Zoro joined his crew
But they were just a few!

The adventure gone next to Buggy the clown
They battled him really down
A girl named Nami they founded fast
So they didn’t needed any cast

On the next island they came with blows
Waiting a dude who lied and had a big nose
Hoping there for a new ship
With Usopp they set out on their trip

They founded something to eat
But they didn’t needed to go feet
It was a restaurant on water
I don’t know what rhymes … maybe slaughter?
Luffy convinced Sanji to be his member
A day that he will always remember
He gets nice food every day
Well that’s something for he pray

They founded a princess and wanted to help
But her pet wasn’t a whelp!
Nami got sick and they musted find a doctor
But they didn’t even found a PROCTOR
After a while they met Chopper
A reindeer that was wearing a topper!
They could make him to be a nakama
And this is a line without any rhyme

And they traveled to Alabasta
Day for day, faster and faster
The only thing they could do there
Is finding a new member, but WHERE ?!
Nico Robin the most wonderful girl
She is beautiful like a pearl
But soon she will met again her background story
Luffy saved her, which was a glory.

They made a funeral for the old ship
THANK YOU FOR THE BEAUTIFUL TRIP
Franky they new binder, that will be funny
Built them the new ship; The Thousand Sunny

They didn’t even need coined
In the moment the last one who joined
Was Brook the skeleton
But this isn’t the peloton.

They were separated for two years
Around the world without any fears
3D2Y was the message to the straw hats
They would meet again without any spats

Well, you want to know how it goes along
Then you have to travel to Hong Kong
No, I’m joking just read the manga or watch the anime
And everyone will be happy (Oda Sensei will!)
            ''',
            style: new TextStyle(
                fontSize: 12.0,
                fontFamily: 'serif',              
            ))
          ],
        )
      );
    }
}