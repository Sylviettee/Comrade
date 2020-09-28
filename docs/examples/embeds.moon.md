
<h2>embeds.moon</h2>
<pre>
<code class="hljs moon">
import Template, Embed from <span class="hljs-global">require</span> <span class="hljs-string">'comrade'</span>

<span class="hljs-comment">-- Normal embeds --
</span>
embed = Embed {
  title: <span class="hljs-string">'You just got level 0'</span>
  description: <span class="hljs-string">'You just got level 0! You now have 5 coins!'</span>
}

embed\send <span class="hljs-string">'channel'</span>

embed = Embed!\setTitle(<span class="hljs-string">'You just got level 0'</span>)\setDescription <span class="hljs-string">'You just got level 0! You now have 5 coins!'</span> <span class="hljs-comment">-- Other method
</span>
embed\send <span class="hljs-string">'channel'</span>

<span class="hljs-comment">-- Templates --
</span>
<span class="hljs-comment">-- Under the hood they use handlebars to handle the rendering
</span>
level = Template { <span class="hljs-comment">-- They extend embeds meaning that they allow for starting points
</span>  title: <span class="hljs-string">'{{user}} just got to level {{level}}'</span>
  description: <span class="hljs-string">'{{user}} got to level {{level}}! You now have {{coins}} coins!'</span>
}

level\render {
  user: <span class="hljs-string">'4 times 1 is even less than 0#3870'</span>,
  level: <span class="hljs-number">5</span>,
  coins: <span class="hljs-string">'2'</span>
}

<span class="hljs-comment">-- Since they use handlebars
</span>
leaderboard = Template {
  title: <span class="hljs-string">"{{guild}}'s leaderboard'"</span>
  description: <span class="hljs-string">'
{{#members}}
{{name}} - {{level}}
{{/members}}
'</span>
}

leaderboard\render {
  members: {
    {name: <span class="hljs-string">'Github Issues'</span>, level: <span class="hljs-number">100</span>}
    {name: <span class="hljs-string">'4 times 1 is even less than 0'</span>, level: <span class="hljs-number">5</span>}
  }
}</code>
</pre>


