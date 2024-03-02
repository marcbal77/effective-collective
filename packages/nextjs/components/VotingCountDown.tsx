import { useEffect, useState } from "react";

interface Props {
  targetDate: Date;
}

const Countdown: React.FC<Props> = ({ targetDate }) => {
  const calculateTimeLeft = () => {
    const now = new Date();
    let difference = targetDate.getTime() - now.getTime();

    if (difference < 0) {
      difference = 0;
    }

    const days = Math.floor(difference / (1000 * 60 * 60 * 24));
    const hours = Math.floor((difference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((difference % (1000 * 60)) / 1000);

    return { days, hours, minutes, seconds };
  };

  const [timeLeft, setTimeLeft] = useState(calculateTimeLeft());

  useEffect(() => {
    const countdownInterval = setInterval(() => {
      setTimeLeft(calculateTimeLeft());
    }, 1000);

    return () => clearInterval(countdownInterval);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [targetDate]);

  return (
    <div>
      <div>
        {timeLeft.days.toString().padStart(2, "0")}:{timeLeft.hours.toString().padStart(2, "0")}:
        {timeLeft.minutes.toString().padStart(2, "0")}:{timeLeft.seconds.toString().padStart(2, "0")}
      </div>
    </div>
  );
};

export default Countdown;
