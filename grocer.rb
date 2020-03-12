def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs

  i = 0
  while i < collection.count do
    if collection[i][:item] == name
      return collection[i]
    end
    i += 1
  end
end

# new_item => item to be added to the cart
# cart => array of hashes, with each hash representing the count of distinct items
def add_item_to_cart(new_item, cart)
  # iterate through the items in the cart
  # if the item already exists; increment the count of that item
  i = 0
  item_found = false
  while i < cart.count do
    if new_item[:name] == cart[i][:name]
      cart[i][:count] += 1
      item_found = true
    end
    i += 1
  end

  # if the item does NOT already exist in the cart, add the item to the cart
  if !item_found
    item_to_add = {
      :item => new_item[:item],
      :price => new_item[:price],
      :clearance => new_item[:clearance],
      :count => 1
    }
    cart << item_to_add
  end
  cart
end

def consolidate_cart(cart)
  sm_cart = []
  lg_index = 0
  while lg_index < cart.count do
    added = false
    sm_index = 0
    while sm_index < sm_cart.count do
      if sm_cart[sm_index][:item] == cart[lg_index][:item]
        # the item already exists in the cart
        qty = sm_cart[sm_index][:count] + 1
        sm_cart[sm_index][:count] = qty
        added = true
      end
      sm_index += 1
    end

    if !added
      new_item = {
        :item => cart[lg_index][:item],
        :price => cart[lg_index][:price],
        :clearance => cart[lg_index][:clearance],
        :count => 1
      }
      sm_cart << new_item
    end

    lg_index += 1
  end
  return sm_cart
end

def apply_coupons(cart, coupons)
  # input:
  # - ary (collection of cart item hashes)
  # - ary (collection of coupon hashes)
  # output:
  # - new ary of hashes (collection of cart items with coupons applied)
  #   - where applicable: "ITEM W/COUPON"
  output = []
  i = 0
  while i < cart.count do
    j = 0
    start_ct = output.count
    while j < coupons.count do
      if coupons[j][:item] == cart[i][:item] and cart[i][:count] >= coupons[j][:num]
        # we can use the coupon
        # remove the items to which the coupon applies
        cart[i][:count] -= coupons[j][:num]
        if cart[i][:count] > 0
          output << cart[i]
        end
        discounted_item = {
          :item => cart[i][:item] + "W/COUPON",
          :price => coupons[j][:price] / coupons[j][:num],
          :clearance => cart[i][:clearance],
          :count => coupon[j][:num]
        }
        output << cart[i]
      end
    end
    # no coupons matched the item
    if start_ct + 1 != output.count
      output << cart[i]
    end
    i += 1
  end
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
