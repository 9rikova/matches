require 'pagy/extras/items'
require 'pagy/extras/metadata'

Pagy::DEFAULT[:items] = 20
Pagy::DEFAULT[:max_items] = 200
Pagy::DEFAULT[:items_param] = :per_page
Pagy::DEFAULT[:metadata] = [:count, :items, :page, :pages, :next, :prev, :last]

# When you are done setting your own default freeze it, so it will not get changed accidentally
Pagy::DEFAULT.freeze