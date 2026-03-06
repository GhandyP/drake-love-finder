import math
from typing import Dict, Tuple


class LoveCalculator:
    """Calculates love probability using an adapted Drake Equation approach."""

    def __init__(self):
        """Initialize the love calculator with default values."""
        self.factors = {
            "demographic_compatibility": 0.5,
            "meeting_opportunities": 0.5,
            "emotional_connection": 0.5,
            "communication_effectiveness": 0.5,
            "compatibility_duration": 0.5,
            "time_frame": 0.5,
        }

    def calculate_love_probability(self) -> float:
        """
        Calculate love probability using adapted Drake Equation.

        Returns:
            float: Love probability percentage (0-100)
        """
        probability = 1.0
        for factor in self.factors.values():
            probability *= factor

        return min(probability * 100, 100)

    def get_insights(self, probability: float) -> str:
        """
        Generate insights based on love probability.

        Args:
            probability: Calculated love probability

        Returns:
            str: Insights about the probability
        """
        if probability >= 90:
            return "¡Excelente! Estás en una posición inmejorable para el amor. Sigue cultivando tus conexiones."
        elif probability >= 75:
            return "¡Muy bien! Tienes un gran potencial para encontrar el amor. Sigue siendo tú mismo/a auténtico/a."
        elif probability >= 60:
            return "¡Bien! Hay posibilidades prometedoras de amor. Concéntrate en construir conexiones significativas."
        elif probability >= 40:
            return "¡Moderado! Hay potencial, pero considera expandir tus círculos sociales o intereses."
        elif probability >= 20:
            return "Bajo a moderado. Tómate un tiempo para trabajar en tu crecimiento personal o explorar nuevas actividades."
        else:
            return "Probabilidad muy baja. Reflexiona sobre lo que buscas y cómo mejorar tu situación."

    def set_factor(self, factor_name: str, value: float) -> bool:
        """
        Set a factor value.

        Args:
            factor_name: Name of the factor to set
            value: Value between 0.0 and 1.0

        Returns:
            bool: True if successful, False otherwise
        """
        if factor_name in self.factors:
            if 0.0 <= value <= 1.0:
                self.factors[factor_name] = value
                return True
        return False

    def get_factors(self) -> Dict[str, float]:
        """Get all current factor values."""
        return self.factors.copy()


class LoveFinderApp:
    """Main application class for the Drake Equation Love Finder."""

    def __init__(self):
        """Initialize the love finder application."""
        self.calculator = LoveCalculator()
        self.running = True

    def display_welcome(self):
        """Display welcome message and explanation."""
        print("=" * 60)
        print("🎉 Drake Equation Love Finder 🎉")
        print("=" * 60)
        print("\nThis application adapts the famous Drake Equation to estimate")
        print("your probability of finding love based on various life factors.")
        print("\nThe Drake Equation originally estimates the number of")
        print("detectable extraterrestrial civilizations in our galaxy.")
        print("We've adapted it for human relationships!")
        print("\nPlease answer the following questions to get your love probability.")
        print("-" * 60)

    def get_user_input(self) -> bool:
        """Collect user inputs for all love factors."""
        factors = [
            (
                "demographic_compatibility",
                "Compatibility with your demographic (0.0-1.0)",
            ),
            ("meeting_opportunities", "Opportunities to meet people (0.0-1.0)"),
            ("emotional_connection", "Ability to form emotional connections (0.0-1.0)"),
            ("communication_effectiveness", "Effectiveness of communication (0.0-1.0)"),
            (
                "compatibility_duration",
                "Likelihood of long-term compatibility (0.0-1.0)",
            ),
            ("time_frame", "Time frame for relationship formation (0.0-1.0)"),
        ]

        print("\nPlease enter values between 0.0 and 1.0 for each factor:")
        print("(0.0 = Very unlikely, 1.0 = Very likely)")

        for factor_name, description in factors:
            while True:
                try:
                    value = float(input(f"\n{description}: "))
                    if 0.0 <= value <= 1.0:
                        self.calculator.set_factor(factor_name, value)
                        break
                    else:
                        print("Value must be between 0.0 and 1.0. Please try again.")
                except ValueError:
                    print("Please enter a valid number between 0.0 and 1.0.")

        return True

    def display_results(self):
        """Display the calculation results and insights."""
        probability = self.calculator.calculate_love_probability()
        insights = self.calculator.get_insights(probability)

        print("\n" + "=" * 60)
        print("📊 LOVE PROBABILITY RESULTS 📊")
        print("=" * 60)
        print(f"Your estimated probability of finding love: {probability:.1f}%")
        print("\n🔍 Detailed Factors:")
        factors = self.calculator.get_factors()
        for factor_name, value in factors.items():
            # Format factor names for display
            display_name = " ".join(
                word.capitalize() for word in factor_name.split("_")
            )
            print(f"  • {display_name}: {value:.2f}")
        print("\n💡 Insights:")
        print(f"  {insights}")
        print("=" * 60)

    def run_simulation(self):
        """Run a single simulation."""
        print("\n🔄 Running Love Simulation...")
        self.get_user_input()
        self.display_results()

    def run(self):
        """Main application loop."""
        self.display_welcome()

        while self.running:
            try:
                self.run_simulation()

                while True:
                    choice = (
                        input("\nWould you like to run another simulation? (y/n): ")
                        .lower()
                        .strip()
                    )
                    if choice in ["y", "yes"]:
                        break
                    elif choice in ["n", "no"]:
                        self.running = False
                        break
                    else:
                        print("Please enter 'y' for yes or 'n' for no.")

            except KeyboardInterrupt:
                print("\n\n👋 Thank you for using the Drake Equation Love Finder!")
                self.running = False
            except Exception as e:
                print(f"\n❌ An error occurred: {str(e)}")
                print("Please try again.")

        print("\n👋 Goodbye! May you find love in all its wonderful forms!")


def main():
    """Entry point of the application."""
    app = LoveFinderApp()
    app.run()


if __name__ == "__main__":
    main()
