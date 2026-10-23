# Flutter Widgets App

Навчальний Flutter-застосунок для демонстрації власних віджетів, анімацій та керування станом.

## Можливості

- **ProfileWidget** - відображення профілю користувача в компактному та розширеному форматах.
- **ProductCard** - картка товару з можливістю додавання до обраного та кошика, анімацією натискання, збільшенням зображення та shimmer-ефектом.
- **AnimatedCounter** - анімований лічильник із прогресом та обмеженням максимального значення.
- **CustomButton** - універсальна кнопка зі стилями Primary, Secondary, Danger та Outline, підтримкою іконок і стану завантаження.
- **AppState** - централізоване керування станом застосунку за допомогою `ChangeNotifier`.
- **Навігація&#x20;**- головна сторінка, каталог товарів і профіль користувача.

## Технології

- Flutter
- Dart
- Material 3
- ChangeNotifier
- Flutter Test
- Integration Test

## Структура проєкту

```text
lib/
├── main.dart
├── models/
│   ├── product.dart
│   └── user.dart
├── screens/
│   ├── home_screen.dart
│   ├── products_screen.dart
│   └── profile_screen.dart
├── utils/
│   └── app_state.dart
└── widgets/
    ├── animated_counter.dart
    ├── custom_button.dart
    ├── product_card.dart
    └── profile_widget.dart

test/
integration_test/
docs/
```

## Запуск проєкту

1. Встановіть Flutter SDK.
2. Клонуйте репозиторій.
3. У терміналі перейдіть до кореневої папки проєкту.
4. Завантажте залежності:

```bash
flutter pub get
```

5. Запустіть застосунок:

```bash
flutter run
```

Для запуску у Windows за наявності відповідного середовища:

```bash
flutter run -d windows
```

## Тестування

Запуск модульних і віджет-тестів:

```bash
flutter test
```

Створення звіту про покриття:

```bash
flutter test --coverage
```

Інтеграційний тест для Windows:

```bash
flutter test integration_test/app_test.dart -d windows
```

Звіт про покриття зберігається у файлі `coverage/lcov.info`.

## Документація

Архітектурна схема, дерево віджетів і API-контракт розміщені в папці `docs/`.

![Головна сторінка](docs/screenshots/home.png)

Навчальний проєкт, створений у межах практичної роботи з Flutter.
