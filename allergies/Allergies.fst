module Allergies
open Bridge

type allergen = Eggs
              | Peanuts
              | Shellfish
              | Strawberries
              | Tomatoes
              | Chocolate
              | Pollen
              | Cats

val allergic_to : native_int -> allergen -> bool

val allergies : native_int -> allergen list
