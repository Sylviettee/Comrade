
<h2>plugin.moon</h2>
<pre>
<code class="hljs moon">
import plugin from <span class="hljs-global">require</span> <span class="hljs-string">'comrade'</span>

class pluginname extends plugin
  new: =&gt;
    super!

    class commandname extends @command <span class="hljs-comment">-- Plugins hold a command method which automatically registers itself to the plugin
</span>      new: =&gt;
        super!

        @name = <span class="hljs-string">''</span> <span class="hljs-comment">-- Override class name
</span>        @aliases = {<span class="hljs-string">''</span>}
        @permissions = {<span class="hljs-string">''</span>} <span class="hljs-comment">-- Uses overrides like if they have Moderation we can override them not having kick members
</span>        @hidden = <span class="hljs-keyword">false</span> <span class="hljs-comment">-- It won't appear in help and can only be ran by an owner
</span>        @allowDMS = <span class="hljs-keyword">false</span>
        @cooldown = <span class="hljs-number">3000</span> <span class="hljs-comment">-- Comes in with a built in MS parser so it can say '3 minutes remaining' or '3 hours'
</span>
        @description = <span class="hljs-string">''</span>
        @usage = <span class="hljs-string">''</span>
        @example = <span class="hljs-string">''</span>

      subcommand: (msg, args, client) =&gt;
        <span class="hljs-comment">-- I only run when you say commandname subcommand
</span>        msg\reply <span class="hljs-string">'Subcommand!'</span>

      execute: (msg, args, client) =&gt;
        <span class="hljs-comment">-- Command logic
</span>        @help msg.channel <span class="hljs-comment">-- Send the help message
</span>
    class messageCreate extends @event <span class="hljs-comment">-- They also hold an event, class name should be the event name
</span>      execute: (msg) =&gt; <span class="hljs-comment">-- No need for super, arguments are the event arguments
</span>        p msg

<span class="hljs-keyword">return</span> pluginname!</code>
</pre>


