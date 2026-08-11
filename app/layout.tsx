import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "小㘵云游｜古村有形，文化有魂",
  description: "小㘵村文化展厅、云游地图、互动游戏、文创与线下体验预约。",
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return <html lang="zh-CN"><body>{children}</body></html>;
}
