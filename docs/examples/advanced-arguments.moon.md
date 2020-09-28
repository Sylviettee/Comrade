
<h2>advanced-arguments.moon</h2>
<pre>
<code class="hljs moon">
import Command, ArgParse from <span class="hljs-global">require</span> <span class="hljs-string">'../init'</span>

class test extends Command
  new: =&gt;
    super!
    @addMiddleware ArgParse { <span class="hljs-comment">-- No changes needed to pre-existing commands
</span>      {
        id: <span class="hljs-string">'numOne'</span>
        <span class="hljs-global">type</span>: <span class="hljs-string">'int'</span>
      },
      {
        id: <span class="hljs-string">'numTwo'</span>
        <span class="hljs-global">type</span>: <span class="hljs-string">'int'</span>
        default: <span class="hljs-number">0</span>
      },
      {
        id: <span class="hljs-string">'member'</span>
        <span class="hljs-global">type</span>: <span class="hljs-string">'member'</span>
        default: (msg) -&gt;
          msg.member
      }
    }, @
  execute: (msg, args) =&gt;
    <span class="hljs-comment">-- Parses args into a table
</span>    sum = args.numOne + args.numTwo
    msg\reply <span class="hljs-string">"The sum is #{sum} and the member is #{args.member.user.tag}!"</span></code>
</pre>


