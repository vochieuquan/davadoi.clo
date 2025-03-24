package model;

public class Discount {
    private String code;
    private double discountValue;
    private boolean isPercentage;
    private boolean isActive;
    private int counter; // Số lần đã sử dụng
    private int maxUsage; // Giới hạn số lần sử dụng

    public Discount(String code, double discountValue, boolean isPercentage, boolean isActive, int counter, int maxUsage) {
        this.code = code;
        this.discountValue = discountValue;
        this.isPercentage = isPercentage;
        this.isActive = isActive;
        this.counter = counter;
        this.maxUsage = maxUsage;
    }

    // Getters & Setters
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }

    public boolean isPercentage() {
        return isPercentage;
    }

    public void setPercentage(boolean percentage) {
        isPercentage = percentage;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public int getCounter() {
        return counter;
    }

    public void setCounter(int counter) {
        this.counter = counter;
    }

    public int getMaxUsage() {
        return maxUsage;
    }

    public void setMaxUsage(int maxUsage) {
        this.maxUsage = maxUsage;
    }

    // Kiểm tra xem có thể sử dụng tiếp không
    public boolean canUse() {
        return isActive && counter < maxUsage;
    }

    // Tăng số lần sử dụng nếu còn trong giới hạn
    public boolean useDiscount() {
        if (canUse()) {
            counter++;
            return true;
        }
        return false;
    }

    @Override
    public String toString() {
        return "Discount{" +
                "code='" + code + '\'' +
                ", discountValue=" + discountValue +
                ", isPercentage=" + isPercentage +
                ", isActive=" + isActive +
                ", counter=" + counter +
                ", maxUsage=" + maxUsage +
                '}';
    }
}
