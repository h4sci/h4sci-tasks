local function ensure_html_deps()
  quarto.doc.add_html_dependency({
    name = "custom-callouts",
    version = "0.1.0",
    stylesheets = {"resources/css/custom-callouts.css"}
  })
end
if quarto.doc.is_format('html:js') then
  ensure_html_deps()
end

local callout_titles = {
  unsplash = 'Unsplash credits',
  tip = 'Tip',
  paper = 'Relevant paper',
  link = 'Useful links',
  question = 'Question',
  pro = 'Pros',
  con = 'Cons'
}

function Div(div)
  -- process callouts
  for callout, defaults in pairs(callout_titles) do
    if div.classes:includes("callout-" .. callout) then
      -- default title
      local title = defaults
      -- Use first element of div as title if this is a header
      if div.content[1] ~= nil and div.content[1].t == "Header" then
        title = pandoc.utils.stringify(div.content[1])
        div.content:remove(1)
      end
      
      
      local old_attr = div.attr
      local appearanceRaw = div.attr.attributes["appearance"]
      local icon = div.attr.attributes["icon"]
      local collapse = div.attr.attributes["collapse"]
      div.attr.attributes["appearance"] = nil
      div.attr.attributes["collapse"] = nil
      div.attr.attributes["icon"] = nil
      
      -- return a callout instead of the Div
      return quarto.Callout({
        appearance = appearanceRaw,
        title = title, 
        collapse = collapse,
        content = div.content,
        icon = icon,
        type = callout,
        attr = old_attr
      })
    end
  end
end
