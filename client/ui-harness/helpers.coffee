###
General purpose helper methods.
###
PKG.Helpers = stampit
  ###
  Retrieves the computed CSS style on the given element.
  @param el:            The element to examine.
  @param propertyName:  The name of the property/attribute.
  @returns string.
  ###
  getStyle: (el, propertyName) ->
    return unless el
    el = el[0] if el.jquery
    window.getComputedStyle(el, null).getPropertyValue(propertyName)

