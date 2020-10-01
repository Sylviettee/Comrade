
<h2>event.moon</h2>
<pre>
<code class="hljs moon">
import Event from <span class="hljs-global">require</span> <span class="hljs-string">'Harmonia'</span>

class messageCreate extends Event <span class="hljs-comment">-- Class name should be the event name
</span>  execute: (msg) =&gt; <span class="hljs-comment">-- No need for super, arguments are the event arguments
</span>    p msg

messageCreate!</code>
</pre>


