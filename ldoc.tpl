<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <link rel="stylesheet" href="https://assets.ubuntu.com/v1/vanilla-framework-version-2.17.0.min.css" />

  <link rel="stylesheet"
      href="//cdn.jsdelivr.net/gh/highlightjs/cdn-release@10.2.0/build/styles/atom-one-light.min.css">

  <title><%= ldoc.project %></title>
</head>
<body>
  <% 
    local no_spaces = ldoc.no_spaces
    local use_li = ldoc.use_li
    local display_name = ldoc.display_name 
    local iter = ldoc.modules.iter
    local function M(txt, item)
      return ldoc.markup(txt, item, ldoc.plain)
    end
    local nowrap = ldoc.wrap and '' or 'nowrap'
  %>
  <div class="p-navigation">
    <div class="p-navigation__row">
      <nav class="p-navigation__nav">
        <ul class="p-navigation__items">
          <li class="navigation__item">
            <a href="../<%= ldoc.output %>.html" class="navigation__link">Home</a>
          </li>
        </ul>

        <form class="p-search-box">
          <input type="search" class="p-search-box__input" name="search" placeholder="Search" required="">
          <button type="reset" class="p-search-box__reset" alt="reset"><i class="p-icon--close"></i></button>
          <button type="submit" class="p-search-box__button" alt="search"><i class="p-icon--search"></i></button>
        </form>
      </nav>
    </div>
  </div>

  <div class="row">
    <div class="col-3">
      <div class="p-side-navigation--raw-html">

        <ul>
          <h2> <%= ldoc.project %> </h2>
          <% if not ldoc.single and module then %>
            <ul>
              <li>
                <a href="../<%= ldoc.output %>.html">
                  Index
                </a>
              </li>
            </ul>
          <% end %>

          <% if ldoc.no_summary and module and not ldoc.one then %>
            <% for kind, items in module.kinds() do %>
              <li><%= kind %></li>

              <ul>

                <% for item in items() do %>
                  <li>
                    <a href="#<%= item.name %>">
                      <% display_name(item) %>
                    </a>
                  </li>
                <% end %>

              </ul>
            <% end %>
          <% end %>

          <% for kind, mods, type in ldoc.kinds() do %>
            <% if ldoc.allowed_in_contents(type, module) then %>
              <h3><%= kind %></h3>

              <ul>
                <% for mod in mods() do 
                  local name = display_name(mod) 
                %>
                  <li>
                    <a href="<%= ldoc.ref_to_module(mod) %>">
                      <%= name %>
                    </a>

                    <% if module and display_name(module) == name and not ldoc.no_summary and #module.items > 0 then %>
                      <ul>
                        <% for kind, items in module.kinds() do %>
                          <li>
                            <a href="#<%= no_spaces(kind) %>">
                              <%= kind %>
                            </a>
                          </li>
                        <% end %>
                      </ul>
                    <% end %>
                  </li>
                <% end %>
              </ul>
            <% end %>
          <% end %>
        </ul>

      </div>
    </div>
    <div class="col-9">
      <% if ldoc.body then %>
        <%- ldoc.body %>
      <% elseif module then %>
        <h1>
          <%= ldoc.module_typename(module) %>
          <code>
            <%= module.name %>
          </code>
        </h1>

        <p> <%- M(module.summary, module) %> </p>
        <p> <%- M(module.description, module) %> </p>

        <% if module.tags.include then %>
          <%= M(ldoc.include_file(module.tags.include)) %>
        <% end %>

        <% if module.see then %>
          <% local li, il = use_li(module.see) %>

          <h3>See also: </h3>
          <ul>
            <% for see in iter(module.see) do %>
              <%= li %> 
                <a href="<%= ldoc.href(see) %>">
                  <%= see.label %>
                </a>
              <%= il %>
            <% end %>
          </ul>
        <% end %>

        <% if module.usage then %>
          <% local li, il = use_li(module.usage) %>

          <h3>Usage: </h3>
          <ul>
            <% for usage in iter(module.usage) do %>
              <%= li %> 
                <pre>
                  <%= ldoc.escape(usage) %>
                </pre>
              <%= il %> 
            <% end %>
          </ul>
        <% end %>

        <% if module.info then %>
          <h3>Info: </h3>
          <ul>
            <% for tag, value in module.info:iter() do %>
              <li>
                <strong><%= tag %></strong>:
                <%= M(value, module) %>
              </li>
            <% end %>
          </ul>
        <% end %>

        <% if not ldoc.no_summary then %>
          <% for kind, items in module.kinds() do %>
            <h2>
              <a href="<%=#no_spaces(kind) %>"><%= kind %></a>
            </h2>

            <table>
              <% for item in items() do %>
                <tr>
                  <td>
                    <a href="#<%= item.name %>">
                      <%= display_name(item) %>
                    </a>
                  </td>
                  <td>
                    <%= M(item.summary, item) %>
                  </td>
                </tr>
              <% end %>
            </table>
          <% end %>
        <% end %>

        <% 
          local show_return = not ldoc.no_return_or_parms
          local show_parms = show_return

          for kind, items in module.kinds() do
            local kitem = module.kinds:get_item(kind)
            local has_description = kitem and ldoc.descript(kitem)
        %>
            <h2>
              <a name="<%= no_spaces(kind) %>"></a>
              <%= kind %>
            </h2>

            <%= M(module.kinds:get_section_description(kind), nil) %>

            <% if kitem then %>
              <% if has_description then %>
                <div>
                  <%= M(ldoc.descript(kitem), kitem) %>
                </div>
              <% end %>

              <% if kitem.usage then %>
                <h3>Usage: </h3>
                
                <pre>
                  <%- ldoc.prettify(kitem.usage[1]) %>
                </pre>
              <% end %>
            <% end %>

            <dl>
              <% for item in items() do %>
                <dt>
                  <a name="<%= item.name %>"></a>
                  <strong><%= display_name(item) %></strong>
                
                  <% if ldoc.prettify_files and ldoc.is_file_prettified[item.module.file.filename] then %>
                    <a style="float:right;" href="<%= ldoc.source_ref(item) %>">
                      Line <%= item.lineno %>
                    </a>
                  <% end %>
                </dt>

                <dd>
                  <%= M(ldoc.descript(item), item) %>
                  
                  <% if ldoc.custom_tags then 
                      for custom in iter(ldoc.custom_tags) do
                        local tag = item.tags[custom[1]]
                        if tag and not custom.hidden then
                          local li, il = use_li(tag)
                  %>
                          <h3><%= custom.title or custom[1] %></h3>
                          <ul>
                            <% for value in iter(tag) do %>
                              <%= li %>
                                <%= custom.format and custom.format(value) or M(value) %>
                              <%= il %>
                            <% end %>
                        <% end %>
                          </ul>
                      <% end %>
                  <% end %>

                  <% if show_parms and item.params and #item.params > 0 then %>
                    <% local subnames = module.kinds:type_of(item).subnames
                    if subnames then %>
                      <h3><%= subnames %>: </h3>
                    <% end %>

                    <ul>
                      <% for parm in iter(item.params) do 
                        local param,sublist = item:subparam(parm)
                        if sublist then %>
                          <li>
                            <span><%= sublist %></span>
                            <%= M(item.params.map[sublist], item) %>
                            <ul>
                        <% end 
                        for p in iter(param) do
                          local name, tp, def = item:display_name_of(p), 
                                                ldoc.typename(item:type_of_param(p)), 
                                                item:default_of_param(p)
                          %>
                              <li>
                                <span><%= name %></span>
                                <% if tp ~= '' then %>
                                  <span><%- tp %></span>
                                <% end %>

                                <%= M(item.params.map[p], item) %>

                                <% if def == true then %>
                                  <em>optional</em>
                                <% elseif def then %>
                                  <em>default</em> <%- def %>
                                <% end %>

                                <% if item:readonly(p) then %>
                                  <em>readonly</em>
                                <% end %>
                              </li>
                        <% end %>
                        <% if sublist then %>
                          </li></ul>
                        <% end %>
                      <% end %>
                    </ul>
                  <% end %>

                  <% if show_return and item.retgroups then
                    local groups = item.retgroups
                  %>
                    <h3>Returns:</h3>
                    <% for i, group in ldoc.ipairs(groups) do
                      local li, il = use_li(group)
                    %>
                      <ol>
                        <% for r in group:iter() do
                          local type, ctypes = item:return_type(r)
                          local rt = ldoc.typename(type)
                        %>
                          <%- li %>
                          <% if rt ~= '' then %>
                            <span><%- rt %></span>
                          <% end %>

                          <%- M(r.text, item) %>
                          <%- il %>

                          <% if ctypes then %>
                            <ul>
                              <% for c in ctypes:iter() do %>
                                <li><span><%- c.name %></span></li>
                                <span><%- ldoc.typename(c.type) %></span>
                                <%- M(c.comment, item) %>
                              <% end %>
                            </ul>
                          <% end %>
                        <% end %>
                      </ol>

                      <% if i < #groups then %>
                        <h3>Or</h3>
                      <% end %>
                    <% end %>
                  <% end %>

                  <% if show_return and item.raise then %>
                    <h3>Raises:</h3>
                    <%= M(item.raise, item) %>
                  <% end %>

                  <% if item.see then 
                    local li, il = use_li(item.see)
                  %>
                    <h3>See also:</h3>
                    <ul>
                      <% for see in iter(item.see) do %>
                        <%- li %>
                          <a href="<%= ldoc.href(see) %>"><%- see.label %></a>
                        <%- il %>
                      <% end %>
                    </ul>
                  <% end %>

                  <% if item.usage then
                    local li, il = use_li(item.usage)
                  %>
                    <h3>Usage:</h3>
                    <ul>
                      <% for usage in iter(item.usage) do %>
                        <%- li %>
                          <pre>
                            <%= ldoc.prettify(usage) %>
                          </pre>
                        <%- il %>
                      <% end %>
                    </ul>
                  <% end %>
                </dd>
              <% end %>
            </dl>

        <% end %>
      <% else %>
        <% if ldoc.description then %>
          <h2><%= M(ldoc.description, nil) %></h2>
        <% end %>

        <% if ldoc.full_description then %>
          <h2><%= M(ldoc.full_description, nil) %></h2>
        <% end %>

        <% for kind, mods in ldoc.kinds() do %>
          <h2><%= kind %></h2>

          <% kind = kind:lower() %>

          <table>
            <% for m in mods() do %>
              <tr>
                <td>
                  <a href="<%= no_spaces(kind) %>/<%= m.name %>.html">
                    <%= m.name %>
                  </a>
                </td>
                <td>
                  <%= M(ldoc.strip_header(m.summary), m) %>
                </td>
              </tr>
            <% end %>
          </table>
        <% end %>
      <% end %>

    </div>
  </div>
</body>
</html>