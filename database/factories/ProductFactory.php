<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Product>
 */
class ProductFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => $this->faker->words(3, true), // Nombre del producto
            'description' => $this->faker->sentence(), // Descripción aleatoria
            'image' => 'https://source.unsplash.com/400x300/?product', // Imagen aleatoria de Unsplash
            'video' => null, // Puedes dejarlo null o asignar URLs reales
            'location' => $this->faker->latitude() . ', ' . $this->faker->longitude(), // Coordenadas aleatorias
            'stock' => $this->faker->numberBetween(0, 50), // Stock entre 0 y 50
            'price' => $this->faker->randomFloat(2, 10, 2000), // Precio entre $10 y $2000
            'discount_price' => function (array $attributes) {
                return $attributes['price'] > 100 ? $attributes['price'] * 0.9 : null; // 10% de descuento si el precio es mayor a $100
            },
            'currency' => 'USD', // Moneda por defecto
            'category' => $this->faker->randomElement(['Celulares', 'Laptops', 'Accesorios', 'Electrodomésticos']), // Categorías aleatorias
            'sku' => strtoupper($this->faker->unique()->lexify('?????-#####')), // SKU aleatorio
            'url' => $this->faker->url,
            'active' => $this->faker->boolean(90), // 90% de los productos estarán activos
        ];
    }
}
