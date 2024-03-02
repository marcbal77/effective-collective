// components/NavigationButton.tsx
import { useRouter } from "next/navigation";

interface Props {
  destination: string;
  label: string;
}

const NavigationButton: React.FC<Props> = ({ destination, label }) => {
  const router = useRouter();

  const handleClick = () => {
    router.push(destination);
  };

  return (
    <button className="btn btn-secondary btn-sm px-2 rounded-full" onClick={handleClick}>
      {label}
    </button>
  );
};

export default NavigationButton;
